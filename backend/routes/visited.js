const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

// Ensure a visited row exists (idempotent mark).
async function markVisited(conn, table, userId, idColumn, id) {
  const [rows] = await conn.query(
    `SELECT 1 FROM ${table} WHERE user_id = ? AND ${idColumn} = ?`,
    [userId, id]
  );
  if (rows.length === 0) {
    await conn.query(
      `INSERT INTO ${table} (user_id, ${idColumn}) VALUES (?, ?)`,
      [userId, id]
    );
  }
}

// Remove a visited row if present (idempotent unmark).
async function unmarkVisited(conn, table, userId, idColumn, id) {
  await conn.query(
    `DELETE FROM ${table} WHERE user_id = ? AND ${idColumn} = ?`,
    [userId, id]
  );
}

// Cascade a marked place up to its city and country (never the reverse).
async function cascadePlaceToCountry(conn, userId, placeId) {
  const [places] = await conn.query('SELECT city_id FROM places WHERE place_id = ?', [placeId]);
  if (places.length === 0) return null;
  const cityId = places[0].city_id;
  if (!cityId) return null;

  await markVisited(conn, 'visited_cities', userId, 'city_id', cityId);

  const [cities] = await conn.query('SELECT country_id FROM cities WHERE city_id = ?', [cityId]);
  if (cities.length === 0 || !cities[0].country_id) return { cityId };
  const countryId = cities[0].country_id;

  await markVisited(conn, 'visited_countries', userId, 'country_id', countryId);
  return { cityId, countryId };
}

async function cascadeCityToCountry(conn, userId, cityId) {
  const [cities] = await conn.query('SELECT country_id FROM cities WHERE city_id = ?', [cityId]);
  if (cities.length === 0 || !cities[0].country_id) return null;
  const countryId = cities[0].country_id;
  await markVisited(conn, 'visited_countries', userId, 'country_id', countryId);
  return { countryId };
}

function effectiveVisited(req) {
  // visited: true|false makes the toggle idempotent; undefined keeps toggle behaviour.
  return req.body.visited === undefined ? null : !!req.body.visited;
}

// ---------------------------------------------------------------- GET lists

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

router.get('/cities', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT vc.*, c.name AS city_name, c.country_id, co.name AS country_name
       FROM visited_cities vc
       JOIN cities c ON vc.city_id = c.city_id
       JOIN countries co ON c.country_id = co.country_id
       WHERE vc.user_id = ?
       ORDER BY vc.visit_date DESC`,
      [req.userId]
    );
    res.json(rows);
  } catch (err) {
    console.error('Get visited cities error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/countries', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT vc.*, c.name AS country_name
       FROM visited_countries vc
       JOIN countries c ON vc.country_id = c.country_id
       WHERE vc.user_id = ?
       ORDER BY vc.visit_date DESC`,
      [req.userId]
    );
    res.json(rows);
  } catch (err) {
    console.error('Get visited countries error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// ---------------------------------------------------------------- toggles

router.post('/places/toggle', authenticateToken, async (req, res) => {
  const { placeId, visitDate, notes } = req.body;
  if (!placeId) return res.status(400).json({ error: 'placeId required' });
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const wantVisited = effectiveVisited(req);
    const [existing] = await conn.query(
      'SELECT 1 FROM visited_places WHERE user_id = ? AND place_id = ?',
      [req.userId, placeId]
    );
    const isVisited = existing.length > 0;
    const shouldBeVisited = wantVisited === null ? !isVisited : wantVisited;

    if (shouldBeVisited) {
      if (isVisited) {
        await conn.query(
          'UPDATE visited_places SET visit_date = COALESCE(?, visit_date), notes = COALESCE(?, notes) WHERE user_id = ? AND place_id = ?',
          [visitDate || null, notes || null, req.userId, placeId]
        );
      } else {
        await conn.query(
          'INSERT INTO visited_places (user_id, place_id, visit_date, notes) VALUES (?, ?, ?, ?)',
          [req.userId, placeId, visitDate || null, notes || null]
        );
      }
      const cascade = await cascadePlaceToCountry(conn, req.userId, placeId);
      await conn.commit();
      res.json({ visited: true, ...(cascade || {}) });
    } else {
      await unmarkVisited(conn, 'visited_places', req.userId, 'place_id', placeId);
      await conn.commit();
      res.json({ visited: false });
    }
  } catch (err) {
    await conn.rollback();
    console.error('Toggle visited place error:', err);
    res.status(500).json({ error: 'Server error' });
  } finally {
    conn.release();
  }
});

router.post('/cities/toggle', authenticateToken, async (req, res) => {
  const { cityId, visitDate, notes } = req.body;
  if (!cityId) return res.status(400).json({ error: 'cityId required' });
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const wantVisited = effectiveVisited(req);
    const [existing] = await conn.query(
      'SELECT 1 FROM visited_cities WHERE user_id = ? AND city_id = ?',
      [req.userId, cityId]
    );
    const isVisited = existing.length > 0;
    const shouldBeVisited = wantVisited === null ? !isVisited : wantVisited;

    if (shouldBeVisited) {
      if (isVisited) {
        await conn.query(
          'UPDATE visited_cities SET visit_date = COALESCE(?, visit_date), notes = COALESCE(?, notes) WHERE user_id = ? AND city_id = ?',
          [visitDate || null, notes || null, req.userId, cityId]
        );
      } else {
        await conn.query(
          'INSERT INTO visited_cities (user_id, city_id, visit_date, notes) VALUES (?, ?, ?, ?)',
          [req.userId, cityId, visitDate || null, notes || null]
        );
      }
      const cascade = await cascadeCityToCountry(conn, req.userId, cityId);
      await conn.commit();
      res.json({ visited: true, ...(cascade || {}) });
    } else {
      await unmarkVisited(conn, 'visited_cities', req.userId, 'city_id', cityId);
      await conn.commit();
      res.json({ visited: false });
    }
  } catch (err) {
    await conn.rollback();
    console.error('Toggle visited city error:', err);
    res.status(500).json({ error: 'Server error' });
  } finally {
    conn.release();
  }
});

router.post('/countries/toggle', authenticateToken, async (req, res) => {
  const { countryId, visitDate, notes } = req.body;
  if (!countryId) return res.status(400).json({ error: 'countryId required' });
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const wantVisited = effectiveVisited(req);
    const [existing] = await conn.query(
      'SELECT 1 FROM visited_countries WHERE user_id = ? AND country_id = ?',
      [req.userId, countryId]
    );
    const isVisited = existing.length > 0;
    const shouldBeVisited = wantVisited === null ? !isVisited : wantVisited;

    if (shouldBeVisited) {
      if (isVisited) {
        await conn.query(
          'UPDATE visited_countries SET visit_date = COALESCE(?, visit_date), notes = COALESCE(?, notes) WHERE user_id = ? AND country_id = ?',
          [visitDate || null, notes || null, req.userId, countryId]
        );
      } else {
        await conn.query(
          'INSERT INTO visited_countries (user_id, country_id, visit_date, notes) VALUES (?, ?, ?, ?)',
          [req.userId, countryId, visitDate || null, notes || null]
        );
      }
      await conn.commit();
      res.json({ visited: true });
    } else {
      await unmarkVisited(conn, 'visited_countries', req.userId, 'country_id', countryId);
      await conn.commit();
      res.json({ visited: false });
    }
  } catch (err) {
    await conn.rollback();
    console.error('Toggle visited country error:', err);
    res.status(500).json({ error: 'Server error' });
  } finally {
    conn.release();
  }
});

module.exports = router;
