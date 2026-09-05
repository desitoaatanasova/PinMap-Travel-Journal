const express = require('express');
const path = require('path');
const fs = require('fs');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');
const { buildUserProfile } = require('../services/profileQueries');

const router = express.Router();
const UPLOADS_ROOT = path.join(__dirname, '..', 'uploads');

function isSafeFilename(name) {
  if (!name || name.includes('..') || name.includes('/') || name.includes('\\')) return false;
  return /^[\w.\-@]+$/.test(name);
}

router.get('/:userId/profile/:filename', authenticateToken, async (req, res) => {
  try {
    const targetUserId = parseInt(req.params.userId, 10);
    const filename = req.params.filename;
    if (!Number.isInteger(targetUserId) || !isSafeFilename(filename)) {
      return res.status(400).json({ error: 'Invalid path' });
    }
    if (req.userId !== targetUserId) {
      const profile = await buildUserProfile(targetUserId, { viewerId: req.userId });
      if (!profile) return res.status(404).json({ error: 'User not found' });
      if (profile.profile_status === 'private' && !profile.isFollowing && targetUserId !== req.userId) {
        return res.status(403).json({ error: 'Profile is private' });
      }
    }
    const filePath = path.join(UPLOADS_ROOT, String(targetUserId), 'profile', filename);
    const resolved = path.resolve(filePath);
    if (!resolved.startsWith(path.resolve(UPLOADS_ROOT))) return res.status(403).json({ error: 'Invalid path' });
    if (!fs.existsSync(resolved)) return res.status(404).json({ error: 'File not found' });
    return res.sendFile(resolved);
  } catch (err) {
    console.error('Serve profile upload error:', err);
    return res.status(500).json({ error: 'Server error' });
  }
});

router.get('/:userId/:journalId/:filename', authenticateToken, async (req, res) => {
  try {
    const userId = parseInt(req.params.userId, 10);
    const journalId = parseInt(req.params.journalId, 10);
    const filename = req.params.filename;
    if (!Number.isInteger(userId) || !Number.isInteger(journalId) || !isSafeFilename(filename)) {
      return res.status(400).json({ error: 'Invalid path' });
    }
    if (req.userId !== userId) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    const [journals] = await pool.query('SELECT journal_id FROM journals WHERE journal_id = ? AND user_id = ?', [journalId, userId]);
    if (journals.length === 0) return res.status(404).json({ error: 'Journal not found' });
    const filePath = path.join(UPLOADS_ROOT, String(userId), String(journalId), filename);
    const resolved = path.resolve(filePath);
    if (!resolved.startsWith(path.resolve(UPLOADS_ROOT))) return res.status(403).json({ error: 'Invalid path' });
    if (!fs.existsSync(resolved)) return res.status(404).json({ error: 'File not found' });
    return res.sendFile(resolved);
  } catch (err) {
    console.error('Serve ticket upload error:', err);
    return res.status(500).json({ error: 'Server error' });
  }
});

router.get('/:userId/*', authenticateToken, async (req, res) => {
  return res.status(404).json({ error: 'File not found' });
});

module.exports = router;
