const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.get('/', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT * FROM journals WHERE user_id = ? ORDER BY created_at DESC', [req.userId]
    );
    for (const journal of rows) {
      const [pages] = await pool.query(
        'SELECT * FROM journal_pages WHERE journal_id = ? ORDER BY page_number', [journal.journal_id]
      );
      for (const page of pages) {
        const [elements] = await pool.query(
          'SELECT * FROM journal_elements WHERE page_id = ? ORDER BY z_index ASC, element_id ASC', [page.page_id]
        );
        page.elements = elements;
      }
      journal.pages = pages;
    }
    res.json(rows);
  } catch (err) {
    console.error('Get journals error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/:id', authenticateToken, async (req, res) => {
  try {
    const [journals] = await pool.query(
      'SELECT * FROM journals WHERE journal_id = ? AND user_id = ?', [req.params.id, req.userId]
    );
    if (journals.length === 0) {
      return res.status(404).json({ error: 'Journal not found' });
    }
    const journal = journals[0];
    const [pages] = await pool.query(
      'SELECT * FROM journal_pages WHERE journal_id = ? ORDER BY page_number', [journal.journal_id]
    );
    for (const page of pages) {
      const [elements] = await pool.query(
        'SELECT * FROM journal_elements WHERE page_id = ? ORDER BY z_index ASC, element_id ASC', [page.page_id]
      );
      page.elements = elements;
    }
    journal.pages = pages;
    res.json(journal);
  } catch (err) {
    console.error('Get journal error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.post('/save', authenticateToken, async (req, res) => {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const { id, title, countryId, coverImage, pages } = req.body;
    let journalId = id;

    if (id) {
      const [existing] = await conn.query(
        'SELECT journal_id FROM journals WHERE journal_id = ? AND user_id = ?', [id, req.userId]
      );
      if (existing.length > 0) {
        await conn.query(
          'UPDATE journals SET title=?, country_id=?, cover_image=? WHERE journal_id=?',
          [title, countryId, coverImage, id]
        );
      } else {
        const [r] = await conn.query(
          'INSERT INTO journals (user_id, title, country_id, cover_image) VALUES (?, ?, ?, ?)',
          [req.userId, title, countryId, coverImage]
        );
        journalId = r.insertId;
      }
    } else {
      const [r] = await conn.query(
        'INSERT INTO journals (user_id, title, country_id, cover_image) VALUES (?, ?, ?, ?)',
        [req.userId, title, countryId, coverImage]
      );
      journalId = r.insertId;
    }

    const savedPages = [];
    if (pages) {
      const [existingPages] = await conn.query(
        'SELECT page_id FROM journal_pages WHERE journal_id = ?', [journalId]
      );
      const existingPageIds = new Set(existingPages.map(p => p.page_id));
      const keptPageIds = new Set();

      for (const page of pages) {
        let pageId;
        const clientPageId = page.pageId;
        if (clientPageId && existingPageIds.has(Number(clientPageId))) {
          pageId = Number(clientPageId);
          await conn.query(
            'UPDATE journal_pages SET page_number=?, background_color=? WHERE page_id=?',
            [page.pageNumber, page.backgroundColor || null, pageId]
          );
        } else {
          const [pageResult] = await conn.query(
            'INSERT INTO journal_pages (journal_id, page_number, background_color) VALUES (?, ?, ?)',
            [journalId, page.pageNumber, page.backgroundColor || null]
          );
          pageId = pageResult.insertId;
        }
        keptPageIds.add(pageId);
        savedPages.push({ pageId, pageNumber: page.pageNumber });

        if (page.elements && page.elements.length > 0) {
          const [existingElements] = await conn.query(
            'SELECT * FROM journal_elements WHERE page_id = ?', [pageId]
          );
          const keepElementIds = new Set();

          for (const el of page.elements) {
            const isMedia = el.elementType === 'image' || el.elementType === 'ticket';
            const content = isMedia ? null : (el.content || null);
            const imageUrl = isMedia ? ((el.imageUrl || el.content) || null) : null;
            const elementKey = el.elementKey || null;

            let match = null;
            if (elementKey) {
              match = existingElements.find(
                e => e.element_key && e.element_key === elementKey
              );
            }
            if (!match && el.elementId) {
              match = existingElements.find(e => e.element_id === Number(el.elementId));
            }

            if (match) {
              // Keep the existing image when a media element is still pending
              // (imageUrl null) so geometry saves don't wipe the upload URL.
              const keepImage = isMedia && imageUrl == null ? match.image_url : imageUrl;
              await conn.query(
                `UPDATE journal_elements SET
                   element_type=?, content=?, image_url=?,
                   x_position=?, y_position=?, width=?, height=?,
                   scale=?, rotation=?, z_index=?,
                   element_key=COALESCE(?, element_key)
                 WHERE element_id=?`,
                [
                  el.elementType, content, keepImage,
                  el.xPosition || 0, el.yPosition || 0, el.width || 200, el.height || 100,
                  el.scale || 1, el.rotation || 0, el.zIndex || 0,
                  elementKey, match.element_id,
                ]
              );
              keepElementIds.add(match.element_id);
            } else {
              const [elResult] = await conn.query(
                `INSERT INTO journal_elements
                   (page_id, element_type, content, image_url, x_position, y_position, width, height, scale, rotation, z_index, element_key)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [
                  pageId, el.elementType, content, imageUrl,
                  el.xPosition || 0, el.yPosition || 0, el.width || 200, el.height || 100,
                  el.scale || 1, el.rotation || 0, el.zIndex || 0,
                  elementKey,
                ]
              );
              keepElementIds.add(elResult.insertId);
            }
          }

          if (keepElementIds.size > 0) {
            const ids = [...keepElementIds];
            await conn.query(
              `DELETE FROM journal_elements WHERE page_id = ? AND element_id NOT IN (${ids.map(() => '?').join(',')})`,
              [pageId, ...ids]
            );
          } else {
            await conn.query('DELETE FROM journal_elements WHERE page_id = ?', [pageId]);
          }
        }
      }

      if (keptPageIds.size > 0) {
        const ids = [...keptPageIds];
        await conn.query(
          `DELETE FROM journal_pages WHERE journal_id = ? AND page_id NOT IN (${ids.map(() => '?').join(',')})`,
          [journalId, ...ids]
        );
      } else {
        await conn.query('DELETE FROM journal_pages WHERE journal_id = ?', [journalId]);
      }
    }

    await conn.commit();
    res.status(201).json({ id: journalId, pages: savedPages });
  } catch (err) {
    await conn.rollback();
    console.error('Save journal error:', err);
    res.status(500).json({ error: 'Server error' });
  } finally {
    conn.release();
  }
});

router.delete('/:id', authenticateToken, async (req, res) => {
  try {
    const [result] = await pool.query(
      'DELETE FROM journals WHERE journal_id = ? AND user_id = ?', [req.params.id, req.userId]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Journal not found' });
    }
    res.json({ success: true });
  } catch (err) {
    console.error('Delete journal error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
