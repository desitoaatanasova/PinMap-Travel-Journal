const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');
const { generateTrip, AiPlannerError } = require('../services/aiPlanner');

const router = express.Router();

router.post('/generate-trip', authenticateToken, async (req, res) => {
  try {
    const {
      countryId,
      countryName,
      numberOfDays,
      startDate,
      endDate,
      tripType,
      travelStyle,
      cityIds,
      cityNames,
      arrivalCity,
      departureCity,
      participants,
    } = req.body;

    if (!countryId || !numberOfDays || numberOfDays < 1 || numberOfDays > 14) {
      return res.status(400).json({
        error: 'countryId and a numberOfDays between 1 and 14 are required',
      });
    }

    const [countries] = await pool.query(
      'SELECT name FROM countries WHERE country_id = ?',
      [countryId]
    );
    if (countries.length === 0) {
      return res.status(400).json({ error: 'Unknown country' });
    }

    const trip = await generateTrip({
      countryId,
      countryName: countryName || countries[0].name,
      numberOfDays,
      startDate,
      endDate,
      tripType,
      travelStyle,
      cityIds,
      cityNames,
      arrivalCity,
      departureCity,
      participants,
    });

    res.status(201).json(trip);
  } catch (err) {
    if (err instanceof AiPlannerError) {
      let status = 502;
      if (err.code === 'AI_NOT_CONFIGURED') status = 503;
      else if (err.code === 'COUNTRY_NO_PLACES' || err.code === 'INSUFFICIENT_PLACES') status = 400;
      else if (err.code === 'AI_TIMEOUT') status = 504;
      else if (err.code === 'AI_RATE_LIMIT') status = 503;
      else if (err.code === 'AI_AUTH_ERROR' || err.code === 'AI_MODEL_NOT_FOUND') status = 503;
      else if (err.code === 'AI_INVALID_RESPONSE' || err.code === 'AI_EMPTY_RESPONSE' || err.code === 'AI_PROVIDER_ERROR') status = 502;
      else if (err.code === 'AI_ERROR') status = 502;
      return res.status(status).json({ error: err.message });
    }
    console.error('Generate trip error:', err);
    if (err && (err.status === 429 || (err.message && err.message.toLowerCase().includes('quota')))) {
      return res.status(503).json({ error: 'AI trip planning is temporarily unavailable. Please try again.' });
    }
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
