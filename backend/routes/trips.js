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
        `SELECT ta.*, p.name AS place_name, p.image_cover AS place_image
         FROM trip_activities ta
         LEFT JOIN places p ON ta.place_id = p.place_id
         WHERE ta.day_id = ?
         ORDER BY FIELD(ta.time_slot, 'Morning', 'Afternoon', 'Evening'), ta.activity_id`,
        [day.day_id]
      );
      day.morning = activities.filter(a => a.time_slot === 'Morning');
      day.afternoon = activities.filter(a => a.time_slot === 'Afternoon');
      day.evening = activities.filter(a => a.time_slot === 'Evening');
    }
    trip.itinerary = days;
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
    const { title, countryId, startDate, endDate, tripType, travelStyle, itinerary } = req.body;
    const [tripResult] = await conn.query(
      'INSERT INTO trips (user_id, title, country_id, start_date, end_date, trip_type, travel_style) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [req.userId, title, countryId, startDate, endDate, tripType, travelStyle]
    );
    const tripId = tripResult.insertId;
    if (itinerary) {
      for (const day of itinerary) {
        const [dayResult] = await conn.query(
          'INSERT INTO trip_days (trip_id, day_number, date) VALUES (?, ?, ?)',
          [tripId, day.dayNumber, day.date || null]
        );
        const dayId = dayResult.insertId;
        const insertActivity = async (activities, timeSlot) => {
          if (activities) {
            for (const act of activities) {
              await conn.query(
                'INSERT INTO trip_activities (day_id, place_id, time_slot, notes) VALUES (?, ?, ?, ?)',
                [dayId, act.placeId || null, timeSlot, act.notes || '']
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
