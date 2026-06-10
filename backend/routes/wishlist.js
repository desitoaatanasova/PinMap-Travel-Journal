const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.get('/', authenticateToken, async (req, res) => {
  try {
    const [placeRows] = await pool.query(
      `SELECT w.wishlist_id, w.place_id, w.country_id, w.added_at,
              'place' AS type,
              p.name, p.image_cover AS image, p.short_description AS description,
              pc.name AS category_name, pc.marker_color AS category_color
       FROM wishlist w
       JOIN places p ON w.place_id = p.place_id
       JOIN place_categories pc ON p.category_id = pc.category_id
       WHERE w.user_id = ? AND w.place_id IS NOT NULL
       ORDER BY w.added_at DESC`,
      [req.userId]
    );
    const [countryRows] = await pool.query(
      `SELECT w.wishlist_id, w.place_id, w.country_id, w.added_at,
              'country' AS type,
              c.name, c.flag_image AS image, c.description,
              NULL AS category_name, NULL AS category_color
       FROM wishlist w
       JOIN countries c ON w.country_id = c.country_id
       WHERE w.user_id = ? AND w.country_id IS NOT NULL
       ORDER BY w.added_at DESC`,
      [req.userId]
    );
    const rows = [...placeRows, ...countryRows];
    rows.sort((a, b) => new Date(b.added_at) - new Date(a.added_at));
    res.json(rows);
  } catch (err) {
    console.error('Get wishlist error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.post('/', authenticateToken, async (req, res) => {
  try {
    const { placeId, countryId } = req.body;
    if (placeId) {
      const [result] = await pool.query(
        'INSERT INTO wishlist (user_id, place_id) VALUES (?, ?)',
        [req.userId, placeId]
      );
      return res.status(201).json({ id: result.insertId, type: 'place' });
    }
    if (countryId) {
      const [result] = await pool.query(
        'INSERT INTO wishlist (user_id, country_id) VALUES (?, ?)',
        [req.userId, countryId]
      );
      return res.status(201).json({ id: result.insertId, type: 'country' });
    }
    res.status(400).json({ error: 'placeId or countryId required' });
  } catch (err) {
    console.error('Add wishlist error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.delete('/:id', authenticateToken, async (req, res) => {
  try {
    const [result] = await pool.query(
      'DELETE FROM wishlist WHERE wishlist_id = ? AND user_id = ?', [req.params.id, req.userId]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Item not found' });
    }
    res.json({ success: true });
  } catch (err) {
    console.error('Delete wishlist error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
