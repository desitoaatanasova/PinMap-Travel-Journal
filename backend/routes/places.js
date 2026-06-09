const express = require('express');
const pool = require('../db');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const { city_id, category_id } = req.query;
    let sql = 'SELECT p.*, pc.name AS category_name, pc.icon AS category_icon, pc.marker_color AS category_marker_color FROM places p JOIN place_categories pc ON p.category_id = pc.category_id WHERE 1=1';
    const params = [];
    if (city_id) {
      sql += ' AND p.city_id = ?';
      params.push(city_id);
    }
    if (category_id) {
      sql += ' AND p.category_id = ?';
      params.push(category_id);
    }
    sql += ' ORDER BY p.name';
    const [rows] = await pool.query(sql, params);

    // Attach photos for each place
    for (const place of rows) {
      const [photos] = await pool.query(
        'SELECT photo_id, image_url FROM place_photos WHERE place_id = ?', [place.place_id]
      );
      place.photos = photos;
    }

    res.json(rows);
  } catch (err) {
    console.error('Get places error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/categories', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM place_categories ORDER BY category_id');
    res.json(rows);
  } catch (err) {
    console.error('Get categories error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
