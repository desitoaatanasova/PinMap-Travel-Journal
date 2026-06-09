const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.get('/places', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT vp.*, p.name AS place_name, p.image_cover AS place_image
       FROM visited_places vp
       JOIN places p ON vp.place_id = p.place_id
       WHERE vp.user_id = ?
       ORDER BY vp.visit_date DESC`,
      [req.userId]
    );
    res.json(rows);
  } catch (err) {
    console.error('Get visited places error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.post('/places/toggle', authenticateToken, async (req, res) => {
  try {
    const { placeId, visitDate, notes } = req.body;
    const [existing] = await pool.query(
      'SELECT 1 FROM visited_places WHERE user_id = ? AND place_id = ?',
      [req.userId, placeId]
    );
    if (existing.length > 0) {
      await pool.query(
        'DELETE FROM visited_places WHERE user_id = ? AND place_id = ?',
        [req.userId, placeId]
      );
      res.json({ visited: false });
    } else {
      await pool.query(
        'INSERT INTO visited_places (user_id, place_id, visit_date, notes) VALUES (?, ?, ?, ?)',
        [req.userId, placeId, visitDate || null, notes || null]
      );
      res.json({ visited: true });
    }
  } catch (err) {
    console.error('Toggle visited place error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
