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
          'SELECT * FROM journal_elements WHERE page_id = ? ORDER BY element_id', [page.page_id]
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
        'SELECT * FROM journal_elements WHERE page_id = ? ORDER BY element_id', [page.page_id]
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

    if (pages) {
      // Delete old pages and elements for this journal
      const [oldPages] = await conn.query(
        'SELECT page_id FROM journal_pages WHERE journal_id = ?', [journalId]
      );
      for (const oldPage of oldPages) {
        await conn.query('DELETE FROM journal_elements WHERE page_id = ?', [oldPage.page_id]);
      }
      await conn.query('DELETE FROM journal_pages WHERE journal_id = ?', [journalId]);

      for (const page of pages) {
        const [pageResult] = await conn.query(
          'INSERT INTO journal_pages (journal_id, page_number, background_color) VALUES (?, ?, ?)',
          [journalId, page.pageNumber, page.backgroundColor || null]
        );
        const pageId = pageResult.insertId;
        if (page.elements) {
          for (const el of page.elements) {
            await conn.query(
              'INSERT INTO journal_elements (page_id, element_type, content, x_position, y_position, width, height) VALUES (?, ?, ?, ?, ?, ?, ?)',
              [pageId, el.elementType, el.content || null, el.xPosition || 0, el.yPosition || 0, el.width || 200, el.height || 100]
            );
          }
        }
      }
    }

    await conn.commit();
    res.status(201).json({ id: journalId });
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
