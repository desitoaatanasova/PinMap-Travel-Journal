const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

const DEFAULT_SETTINGS = {
  notificationsEnabled: true,
  offlineModeEnabled: false,
  language: 'English',
};

async function ensureSettings(userId) {
  const [rows] = await pool.query(
    'SELECT user_id, notifications_enabled, offline_mode_enabled, language FROM user_settings WHERE user_id = ?',
    [userId]
  );
  if (rows.length > 0) return rows[0];
  await pool.query(
    'INSERT INTO user_settings (user_id) VALUES (?)',
    [userId]
  );
  const [fresh] = await pool.query(
    'SELECT user_id, notifications_enabled, offline_mode_enabled, language FROM user_settings WHERE user_id = ?',
    [userId]
  );
  return fresh[0];
}

function toClient(row) {
  return {
    userId: row.user_id,
    notificationsEnabled: !!row.notifications_enabled,
    offlineModeEnabled: !!row.offline_mode_enabled,
    language: row.language,
  };
}

router.get('/', authenticateToken, async (req, res) => {
  try {
    const row = await ensureSettings(req.userId);
    res.json(toClient(row));
  } catch (err) {
    console.error('Get settings error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.put('/', authenticateToken, async (req, res) => {
  try {
    await ensureSettings(req.userId);
    const { notificationsEnabled, offlineModeEnabled, language } = req.body;
    const sets = [];
    const params = [];
    if (typeof notificationsEnabled === 'boolean') {
      sets.push('notifications_enabled = ?');
      params.push(notificationsEnabled ? 1 : 0);
    }
    if (typeof offlineModeEnabled === 'boolean') {
      sets.push('offline_mode_enabled = ?');
      params.push(offlineModeEnabled ? 1 : 0);
    }
    if (typeof language === 'string' && language.trim()) {
      sets.push('language = ?');
      params.push(language.trim());
    }
    if (sets.length > 0) {
      params.push(req.userId);
      await pool.query(`UPDATE user_settings SET ${sets.join(', ')} WHERE user_id = ?`, params);
    }
    const row = await ensureSettings(req.userId);
    res.json(toClient(row));
  } catch (err) {
    console.error('Update settings error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
