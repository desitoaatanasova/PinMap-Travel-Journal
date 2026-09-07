const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const includeCities = req.query.include === 'cities';
    const [rows] = await pool.query('SELECT * FROM countries ORDER BY name');
    if (!includeCities) {
      res.json(rows);
      return;
    }
    if (rows.length === 0) {
      res.json(rows);
      return;
    }
    const ids = rows.map((r) => r.country_id);
    const [cities] = await pool.query(
      `SELECT * FROM cities WHERE country_id IN (${ids.map(() => '?').join(',')}) ORDER BY country_id, name`,
      ids
    );
    const byCountry = new Map();
    for (const c of cities) {
      if (!byCountry.has(c.country_id)) byCountry.set(c.country_id, []);
      byCountry.get(c.country_id).push(c);
    }
    res.json(rows.map((r) => ({ ...r, cities: byCountry.get(r.country_id) || [] })));
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
