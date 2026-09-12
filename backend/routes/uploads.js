const express = require('express');
const fs = require('fs');
const fsp = require('fs/promises');
const path = require('path');
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
    try { await fsp.access(resolved, fs.constants.R_OK); } catch { return res.status(404).json({ error: 'File not found' }); }
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
    const [journals] = await pool.query('SELECT journal_id, user_id, visibility FROM journals WHERE journal_id = ?', [journalId]);
    if (journals.length === 0) return res.status(404).json({ error: 'Journal not found' });
    const journal = journals[0];
    if (String(journal.user_id) !== String(userId)) {
      return res.status(404).json({ error: 'Journal not found' });
    }
    if (req.userId !== journal.user_id) {
      if ((journal.visibility || 'private') !== 'public') {
        return res.status(403).json({ error: 'Forbidden' });
      }
      const profile = await buildUserProfile(journal.user_id, { viewerId: req.userId });
      if (!profile) return res.status(404).json({ error: 'User not found' });
      if (profile.profile_status === 'private' && !profile.isFollowing) {
        return res.status(403).json({ error: 'Profile is private' });
      }
    }
    const filePath = path.join(UPLOADS_ROOT, String(userId), String(journalId), filename);
    const resolved = path.resolve(filePath);
    if (!resolved.startsWith(path.resolve(UPLOADS_ROOT))) return res.status(403).json({ error: 'Invalid path' });
    try { await fsp.access(resolved, fs.constants.R_OK); } catch { return res.status(404).json({ error: 'File not found' }); }
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
