const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM countries ORDER BY name');
    res.json(rows);
  } catch (err) {
    console.error('Get countries error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const [countries] = await pool.query('SELECT * FROM countries WHERE country_id = ?', [req.params.id]);
    if (countries.length === 0) {
      return res.status(404).json({ error: 'Country not found' });
    }
    const [cities] = await pool.query('SELECT * FROM cities WHERE country_id = ? ORDER BY name', [req.params.id]);
    res.json({ ...countries[0], cities });
  } catch (err) {
    console.error('Get country error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
