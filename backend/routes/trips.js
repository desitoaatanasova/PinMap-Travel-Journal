const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.get('/', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT * FROM trips WHERE user_id = ? ORDER BY start_date DESC', [req.userId]
    );
    res.json(rows);
  } catch (err) {
    console.error('Get trips error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/:id', authenticateToken, async (req, res) => {
  try {
    const [trips] = await pool.query(
      'SELECT * FROM trips WHERE trip_id = ? AND user_id = ?', [req.params.id, req.userId]
    );
    if (trips.length === 0) {
      return res.status(404).json({ error: 'Trip not found' });
    }
    const trip = trips[0];
    const [days] = await pool.query('SELECT * FROM trip_days WHERE trip_id = ? ORDER BY day_number', [trip.trip_id]);
    for (const day of days) {
      const [activities] = await pool.query(
        `SELECT ta.*, p.name AS place_name, p.image_cover AS place_image,
                p.latitude, p.longitude, p.category_id, c.name AS city_name
         FROM trip_activities ta
         LEFT JOIN places p ON ta.place_id = p.place_id
         LEFT JOIN cities c ON p.city_id = c.city_id
         WHERE ta.day_id = ?
         ORDER BY FIELD(ta.time_slot, 'Morning', 'Afternoon', 'Evening'), ta.order_index, ta.activity_id`,
        [day.day_id]
      );
      day.morning = activities.filter(a => a.time_slot === 'Morning');
      day.afternoon = activities.filter(a => a.time_slot === 'Afternoon');
      day.evening = activities.filter(a => a.time_slot === 'Evening');
    }
    trip.itinerary = days;
    const [cities] = await pool.query(
      'SELECT city_id FROM trip_cities WHERE trip_id = ? ORDER BY city_id', [trip.trip_id]
    );
    trip.cityIds = cities.map((c) => c.city_id);
    const [participants] = await pool.query(
      `SELECT tp.user_id, u.username, u.first_name, u.last_name, u.profile_picture
       FROM trip_participants tp
       JOIN users u ON u.user_id = tp.user_id
       WHERE tp.trip_id = ? ORDER BY u.username`,
      [trip.trip_id]
    );
    trip.participants = participants;
    res.json(trip);
  } catch (err) {
    console.error('Get trip error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.post('/', authenticateToken, async (req, res) => {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const { title, countryId, startDate, endDate, tripType, travelStyle, itinerary, arrivalCity, departureCity, cityIds, participantIds, clientId } = req.body;
    if (clientId != null && (typeof clientId !== 'string' || clientId.length > 64)) {
      await conn.rollback();
      return res.status(400).json({ error: 'clientId must be a string max 64 chars' });
    }
    if (typeof title !== 'string' || title.trim().length === 0) {
      await conn.rollback();
      return res.status(400).json({ error: 'title is required' });
    }
    if (title.trim().length > 200) {
      await conn.rollback();
      return res.status(400).json({ error: 'title must be max 200 chars' });
    }
    if (countryId != null) {
      const cid = parseInt(countryId, 10);
      if (!Number.isInteger(cid) || cid <= 0) {
        await conn.rollback();
        return res.status(400).json({ error: 'Invalid countryId' });
      }
      const [c] = await conn.query('SELECT country_id FROM countries WHERE country_id = ?', [cid]);
      if (c.length === 0) {
        await conn.rollback();
        return res.status(404).json({ error: 'Country not found' });
      }
    }
    if (startDate != null || endDate != null) {
      const s = startDate ? new Date(startDate) : null;
      const e = endDate ? new Date(endDate) : null;
      if ((startDate && isNaN(s.getTime())) || (endDate && isNaN(e.getTime()))) {
        await conn.rollback();
        return res.status(400).json({ error: 'Invalid date' });
      }
      if (s && e && s > e) {
        await conn.rollback();
        return res.status(400).json({ error: 'startDate must be <= endDate' });
      }
    }
    if (clientId) {
      const [existing] = await conn.query(
        'SELECT trip_id FROM trips WHERE user_id = ? AND client_id = ?',
        [req.userId, clientId]
      );
      if (existing.length > 0) {
        await conn.commit();
        return res.status(200).json({ id: existing[0].trip_id, deduped: true });
      }
    }
    const numberOfDays =
      req.body.numberOfDays ??
      (itinerary && itinerary.length > 0
        ? itinerary.length
        : startDate && endDate
          ? Math.round((new Date(endDate) - new Date(startDate)) / 86400000) + 1
          : null);
    const [tripResult] = await conn.query(
      'INSERT INTO trips (user_id, client_id, title, country_id, start_date, end_date, trip_type, travel_style, number_of_days, arrival_city, departure_city) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [req.userId, clientId || null, title, countryId, startDate, endDate, tripType, travelStyle, numberOfDays, arrivalCity || null, departureCity || null]
    );
    const tripId = tripResult.insertId;
    if (Array.isArray(cityIds) && cityIds.length > 0) {
      for (const cityId of cityIds) {
        if (Number.isInteger(cityId)) {
          await conn.query(
            'INSERT IGNORE INTO trip_cities (trip_id, city_id) VALUES (?, ?)',
            [tripId, cityId]
          );
        }
      }
    }
    if (Array.isArray(participantIds) && participantIds.length > 0) {
      for (const userId of participantIds) {
        if (Number.isInteger(userId)) {
          await conn.query(
            'INSERT IGNORE INTO trip_participants (trip_id, user_id) VALUES (?, ?)',
            [tripId, userId]
          );
        }
      }
    }
    if (itinerary) {
      for (const day of itinerary) {
        const [dayResult] = await conn.query(
          'INSERT INTO trip_days (trip_id, day_number, date) VALUES (?, ?, ?)',
          [tripId, day.dayNumber, day.date || null]
        );
        const dayId = dayResult.insertId;
        const insertActivity = async (activities, timeSlot) => {
          if (activities) {
            for (let i = 0; i < activities.length; i++) {
              const act = activities[i];
              await conn.query(
                'INSERT INTO trip_activities (day_id, place_id, order_index, time_slot, notes) VALUES (?, ?, ?, ?, ?)',
                [dayId, act.placeId || null, i, timeSlot, act.notes || '']
              );
            }
          }
        };
        await insertActivity(day.morning, 'Morning');
        await insertActivity(day.afternoon, 'Afternoon');
        await insertActivity(day.evening, 'Evening');
      }
    }
    await conn.commit();
    res.status(201).json({ id: tripId });
  } catch (err) {
    await conn.rollback();
    console.error('Create trip error:', err);
    res.status(500).json({ error: 'Server error' });
  } finally {
    conn.release();
  }
});

router.put('/:id', authenticateToken, async (req, res) => {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const [existing] = await conn.query(
      'SELECT trip_id FROM trips WHERE trip_id = ? AND user_id = ?',
      [req.params.id, req.userId]
    );
    if (existing.length === 0) {
      await conn.rollback();
      return res.status(404).json({ error: 'Trip not found' });
    }
    const { title, countryId, startDate, endDate, tripType, travelStyle, itinerary, arrivalCity, departureCity, cityIds, participantIds } = req.body;
    if (title != null && (typeof title !== 'string' || title.trim().length === 0 || title.trim().length > 200)) {
      await conn.rollback();
      return res.status(400).json({ error: 'title must be 1-200 chars' });
    }
    if (countryId != null) {
      const cid = parseInt(countryId, 10);
      if (!Number.isInteger(cid) || cid <= 0) {
        await conn.rollback();
        return res.status(400).json({ error: 'Invalid countryId' });
      }
      const [c] = await conn.query('SELECT country_id FROM countries WHERE country_id = ?', [cid]);
      if (c.length === 0) {
        await conn.rollback();
        return res.status(404).json({ error: 'Country not found' });
      }
    }
    if (startDate != null || endDate != null) {
      const s = startDate ? new Date(startDate) : null;
      const e = endDate ? new Date(endDate) : null;
      if ((startDate && isNaN(s.getTime())) || (endDate && isNaN(e.getTime()))) {
        await conn.rollback();
        return res.status(400).json({ error: 'Invalid date' });
      }
      if (s && e && s > e) {
        await conn.rollback();
        return res.status(400).json({ error: 'startDate must be <= endDate' });
      }
    }
    const numberOfDays =
      req.body.numberOfDays ??
      (itinerary && itinerary.length > 0
        ? itinerary.length
        : startDate && endDate
          ? Math.round((new Date(endDate) - new Date(startDate)) / 86400000) + 1
          : null);
    await conn.query(
      'UPDATE trips SET title=?, country_id=?, start_date=?, end_date=?, trip_type=?, travel_style=?, number_of_days=?, arrival_city=?, departure_city=? WHERE trip_id=?',
      [title, countryId, startDate, endDate, tripType, travelStyle, numberOfDays, arrivalCity || null, departureCity || null, req.params.id]
    );
    await conn.query('DELETE FROM trip_cities WHERE trip_id = ?', [req.params.id]);
    await conn.query('DELETE FROM trip_participants WHERE trip_id = ?', [req.params.id]);
    if (Array.isArray(cityIds) && cityIds.length > 0) {
      for (const cityId of cityIds) {
        if (Number.isInteger(cityId)) {
          await conn.query(
            'INSERT IGNORE INTO trip_cities (trip_id, city_id) VALUES (?, ?)',
            [req.params.id, cityId]
          );
        }
      }
    }
    if (Array.isArray(participantIds) && participantIds.length > 0) {
      for (const userId of participantIds) {
        if (Number.isInteger(userId)) {
          await conn.query(
            'INSERT IGNORE INTO trip_participants (trip_id, user_id) VALUES (?, ?)',
            [req.params.id, userId]
          );
        }
      }
    }
    await conn.query('DELETE FROM trip_days WHERE trip_id = ?', [req.params.id]);
    if (itinerary) {
      for (const day of itinerary) {
        const [dayResult] = await conn.query(
          'INSERT INTO trip_days (trip_id, day_number, date) VALUES (?, ?, ?)',
          [req.params.id, day.dayNumber, day.date || null]
        );
        const dayId = dayResult.insertId;
        const insertActivity = async (activities, timeSlot) => {
          if (activities) {
            for (let i = 0; i < activities.length; i++) {
              const act = activities[i];
              await conn.query(
                'INSERT INTO trip_activities (day_id, place_id, order_index, time_slot, notes) VALUES (?, ?, ?, ?, ?)',
                [dayId, act.placeId || null, i, timeSlot, act.notes || '']
              );
            }
          }
        };
        await insertActivity(day.morning, 'Morning');
        await insertActivity(day.afternoon, 'Afternoon');
        await insertActivity(day.evening, 'Evening');
      }
    }
    await conn.commit();
    res.json({ id: req.params.id });
  } catch (err) {
    await conn.rollback();
    console.error('Update trip error:', err);
    res.status(500).json({ error: 'Server error' });
  } finally {
    conn.release();
  }
});

router.delete('/:id', authenticateToken, async (req, res) => {
  try {
    const [result] = await pool.query(
      'DELETE FROM trips WHERE trip_id = ? AND user_id = ?', [req.params.id, req.userId]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Trip not found' });
    }
    res.json({ success: true });
  } catch (err) {
    console.error('Delete trip error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
