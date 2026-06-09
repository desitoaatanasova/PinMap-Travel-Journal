const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.get('/', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT w.*, p.name AS place_name, p.image_cover AS place_image, p.short_description AS place_description,
              pc.name AS category_name, pc.marker_color AS category_color
       FROM wishlist w
       JOIN places p ON w.place_id = p.place_id
       JOIN place_categories pc ON p.category_id = pc.category_id
       WHERE w.user_id = ?
       ORDER BY w.added_at DESC`,
      [req.userId]
    );
    res.json(rows);
  } catch (err) {
    console.error('Get wishlist error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.post('/', authenticateToken, async (req, res) => {
  try {
    const { placeId } = req.body;
    const [result] = await pool.query(
      'INSERT INTO wishlist (user_id, place_id) VALUES (?, ?)',
      [req.userId, placeId]
    );
    res.status(201).json({ id: result.insertId });
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
