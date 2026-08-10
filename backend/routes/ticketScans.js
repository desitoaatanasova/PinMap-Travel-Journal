const express = require('express');
const path = require('path');
const fs = require('fs');
const fsp = require('fs/promises');
const multer = require('multer');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

const UPLOADS_ROOT = path.join(__dirname, '..', 'uploads');

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 20 * 1024 * 1024 },
});

function ensureDir(dir) {
  return fsp.mkdir(dir, { recursive: true });
}

async function nextTicketNumber(dir) {
  await ensureDir(dir);
  const entries = await fsp.readdir(dir).catch(() => []);
  const used = new Set();
  for (const name of entries) {
    const match = name.match(/^ticket_(\d+)(?:_original)?\./);
    if (match) used.add(parseInt(match[1], 10));
  }
  let n = 1;
  while (used.has(n)) n += 1;
  return n;
}

function extFromMime(mime) {
  if (!mime) return '.png';
  if (mime.includes('jpeg') || mime.includes('jpg')) return '.jpg';
  if (mime.includes('webp')) return '.webp';
  return '.png';
}

async function resolveJournal(conn, userId, { journalId, journalTitle, countryId }) {
  if (journalId) {
    const [existing] = await conn.query(
      'SELECT journal_id FROM journals WHERE journal_id = ? AND user_id = ?',
      [journalId, userId]
    );
    if (existing.length > 0) return existing[0].journal_id;
  }

  let cid = countryId ? parseInt(countryId, 10) : 0;
  if (!cid) {
    const [first] = await conn.query('SELECT MIN(country_id) AS cid FROM countries');
    cid = (first[0] && first[0].cid) || 0;
  }

  const [r] = await conn.query(
    'INSERT INTO journals (user_id, title, country_id) VALUES (?, ?, ?)',
    [userId, journalTitle || 'New Journal', cid]
  );
  return r.insertId;
}

async function resolvePage(conn, journalId, pageId) {
  if (pageId) {
    const [existing] = await conn.query(
      'SELECT page_id FROM journal_pages WHERE page_id = ? AND journal_id = ?',
      [pageId, journalId]
    );
    if (existing.length > 0) return existing[0].page_id;
  }
  // Prefer reusing an existing page so we never create duplicate page 1s.
  const [first] = await conn.query(
    'SELECT page_id FROM journal_pages WHERE journal_id = ? ORDER BY page_number, page_id LIMIT 1',
    [journalId]
  );
  if (first.length > 0) return first[0].page_id;

  const [r] = await conn.query(
    'INSERT INTO journal_pages (journal_id, page_number) VALUES (?, 1)',
    [journalId]
  );
  return r.insertId;
}

// POST /api/tickets  (multipart: files original + processed, fields: metadata)
router.post('/', authenticateToken, upload.fields([{ name: 'original', maxCount: 1 }, { name: 'processed', maxCount: 1 }]), async (req, res) => {
  const files = req.files || {};
  const original = files.original ? files.original[0] : null;
  const processed = files.processed ? files.processed[0] : null;

  if (!processed && !original) {
    return res.status(400).json({ error: 'At least one image is required' });
  }

  const conn = await pool.getConnection();
  let journalDir = null;
  try {
    await conn.beginTransaction();

    const journalId = await resolveJournal(conn, req.userId, {
      journalId: req.body.journalId,
      journalTitle: req.body.journalTitle,
      countryId: req.body.countryId,
    });
    const pageId = await resolvePage(conn, journalId, req.body.pageId);

    const dir = path.join(UPLOADS_ROOT, String(req.userId), String(journalId));
    const n = await nextTicketNumber(dir);
    journalDir = dir;

    const processedExt = processed ? extFromMime(processed.mimetype) : '.png';
    const processedName = `ticket_${String(n).padStart(3, '0')}${processedExt}`;
    const originalExt = original ? extFromMime(original.mimetype) : null;
    const originalName = originalExt ? `ticket_${String(n).padStart(3, '0')}_original${originalExt}` : null;

    if (processed) {
      await ensureDir(dir);
      await fsp.writeFile(path.join(dir, processedName), processed.buffer);
    }
    if (original && originalName) {
      await ensureDir(dir);
      await fsp.writeFile(path.join(dir, originalName), original.buffer);
    }

    const baseUrl = '/uploads';
    const processedUrl = processed ? `${baseUrl}/${req.userId}/${journalId}/${processedName}` : null;
    const originalUrl = original && originalName ? `${baseUrl}/${req.userId}/${journalId}/${originalName}` : null;

    const backgroundRemoved = req.body.backgroundRemoved === 'true' || req.body.backgroundRemoved === true ? 1 : 0;

    const [scan] = await conn.query(
      'INSERT INTO ticket_scans (user_id, journal_id, page_id, original_image_url, processed_image_url, background_removed) VALUES (?, ?, ?, ?, ?, ?)',
      [req.userId, journalId, pageId, originalUrl, processedUrl, backgroundRemoved]
    );

    const elementType = req.body.elementType || 'ticket';
    const elementContent = processedUrl || originalUrl;
    const elementKey = req.body.elementKey || null;

    // Upsert the journal element by its stable client key so geometry edits to
    // pending (offline) media are preserved when the upload finally lands.
    let elementId = null;
    if (elementKey) {
      const [existingEl] = await conn.query(
        'SELECT element_id FROM journal_elements WHERE page_id = ? AND element_key = ?',
        [pageId, elementKey]
      );
      if (existingEl.length > 0) {
        elementId = existingEl[0].element_id;
        await conn.query(
          `UPDATE journal_elements SET
             element_type=?, image_url=?, x_position=?, y_position=?,
             width=?, height=?, scale=?, rotation=?, z_index=?
           WHERE element_id=?`,
          [
            elementType, elementContent,
            parseInt(req.body.xPosition, 10) || 0,
            parseInt(req.body.yPosition, 10) || 0,
            parseInt(req.body.width, 10) || 200,
            parseInt(req.body.height, 10) || 100,
            parseFloat(req.body.scale) || 1,
            parseFloat(req.body.rotation) || 0,
            parseInt(req.body.zIndex, 10) || 0,
            elementId,
          ]
        );
      }
    }
    if (!elementId) {
      const [el] = await conn.query(
        `INSERT INTO journal_elements
           (page_id, element_type, content, image_url, x_position, y_position, width, height, scale, rotation, z_index, element_key)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          pageId,
          elementType,
          null,
          elementContent,
          parseInt(req.body.xPosition, 10) || 0,
          parseInt(req.body.yPosition, 10) || 0,
          parseInt(req.body.width, 10) || 200,
          parseInt(req.body.height, 10) || 100,
          parseFloat(req.body.scale) || 1,
          parseFloat(req.body.rotation) || 0,
          parseInt(req.body.zIndex, 10) || 0,
          elementKey,
        ]
      );
      elementId = el.insertId;
    }

    await conn.commit();
    res.status(201).json({
      ticketId: scan.insertId,
      elementId: el.insertId,
      journalId,
      pageId,
      originalImageUrl: originalUrl,
      processedImageUrl: processedUrl,
      backgroundRemoved,
    });
  } catch (err) {
    await conn.rollback();
    if (journalDir) {
      await fsp.readdir(journalDir).catch(() => []);
    }
    console.error('Upload ticket error:', err);
    res.status(500).json({ error: 'Server error' });
  } finally {
    conn.release();
  }
});

// GET /api/tickets?journalId=  -> list scans for a journal
router.get('/', authenticateToken, async (req, res) => {
  try {
    const journalId = req.query.journalId;
    if (!journalId) return res.status(400).json({ error: 'journalId required' });
    const [rows] = await pool.query(
      'SELECT * FROM ticket_scans WHERE user_id = ? AND journal_id = ? ORDER BY created_at DESC',
      [req.userId, journalId]
    );
    res.json(rows);
  } catch (err) {
    console.error('Get tickets error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/tickets/:id  -> remove the record (files are kept on disk)
router.delete('/:id', authenticateToken, async (req, res) => {
  try {
    const [result] = await pool.query(
      'DELETE FROM ticket_scans WHERE ticket_id = ? AND user_id = ?',
      [req.params.id, req.userId]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Ticket not found' });
    }
    res.json({ success: true });
  } catch (err) {
    console.error('Delete ticket error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
