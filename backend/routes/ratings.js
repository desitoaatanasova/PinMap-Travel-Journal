const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

function validateRating(rating) {
  const r = parseInt(rating, 10);
  if (Number.isNaN(r) || r < 1 || r > 5) return null;
  return r;
}

async function getAggregate(userId, placeId, countryId) {
  const where = placeId != null ? 'place_id = ?' : 'country_id = ?';
  const value = placeId != null ? placeId : countryId;
  const [rows] = await pool.query(
    `SELECT AVG(rating) AS average, COUNT(*) AS cnt
     FROM ratings WHERE ${where}`,
    [value]
  );
  let myRating = null;
  if (userId) {
    const [mine] = await pool.query(
      `SELECT rating FROM ratings WHERE user_id = ? AND ${where}`,
      [userId, value]
    );
    if (mine.length > 0) myRating = mine[0].rating;
  }
  return {
    average: rows[0].average == null ? null : Number(rows[0].average),
    count: rows[0].cnt,
    myRating,
  };
}

// POST /api/ratings  { placeId? | countryId?, rating }
router.post('/', authenticateToken, async (req, res) => {
  try {
    const { placeId, countryId, rating } = req.body;
    const r = validateRating(rating);
    if (r === null) return res.status(400).json({ error: 'rating must be 1-5' });
    if (placeId == null && countryId == null) {
      return res.status(400).json({ error: 'placeId or countryId required' });
    }
    if (placeId != null) {
      await pool.query(
        `INSERT INTO ratings (user_id, place_id, rating)
         VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE rating = VALUES(rating)`,
        [req.userId, placeId, r]
      );
    } else {
      await pool.query(
        `INSERT INTO ratings (user_id, country_id, rating)
         VALUES (?, ?, ?)
         ON DUPLICATE KEY UPDATE rating = VALUES(rating)`,
        [req.userId, countryId, r]
      );
    }
    const agg = await getAggregate(
      req.userId,
      placeId != null ? placeId : null,
      countryId != null ? countryId : null
    );
    res.status(201).json({ rating: r, ...agg });
  } catch (err) {
    console.error('Save rating error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/place/:id', authenticateToken, async (req, res) => {
  try {
    const agg = await getAggregate(req.userId, req.params.id, null);
    res.json(agg);
  } catch (err) {
    console.error('Get place rating error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/country/:id', authenticateToken, async (req, res) => {
  try {
    const agg = await getAggregate(req.userId, null, req.params.id);
    res.json(agg);
  } catch (err) {
    console.error('Get country rating error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.delete('/place/:id', authenticateToken, async (req, res) => {
  try {
    await pool.query(
      'DELETE FROM ratings WHERE user_id = ? AND place_id = ?',
      [req.userId, req.params.id]
    );
    const agg = await getAggregate(req.userId, req.params.id, null);
    res.json({ success: true, ...agg });
  } catch (err) {
    console.error('Delete place rating error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.delete('/country/:id', authenticateToken, async (req, res) => {
  try {
    await pool.query(
      'DELETE FROM ratings WHERE user_id = ? AND country_id = ?',
      [req.userId, req.params.id]
    );
    const agg = await getAggregate(req.userId, null, req.params.id);
    res.json({ success: true, ...agg });
  } catch (err) {
    console.error('Delete country rating error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
