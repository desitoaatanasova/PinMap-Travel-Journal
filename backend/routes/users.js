const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');
const { buildUserProfile } = require('../services/profileQueries');

const router = express.Router();

// GET /api/users/search?q=...
router.get('/search', authenticateToken, async (req, res) => {
  try {
    const q = (req.query.q || '').trim();
    if (q.length < 1) {
      return res.json([]);
    }
    const like = `%${q}%`;
    const [rows] = await pool.query(
      `SELECT user_id, username, first_name, last_name, bio, profile_picture, profile_status
       FROM users
       WHERE user_id != ? AND (username LIKE ? OR first_name LIKE ? OR last_name LIKE ?)
       ORDER BY username
       LIMIT 20`,
      [req.userId, like, like, like]
    );
    res.json(
      rows.map((u) => ({
        userId: u.user_id,
        username: u.username,
        firstName: u.first_name,
        lastName: u.last_name,
        bio: u.bio,
        profilePicture: u.profile_picture,
        profileStatus: u.profile_status,
      }))
    );
  } catch (err) {
    console.error('Search users error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/users/mutual  - users that I follow AND that follow me back
router.get('/mutual', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT u.user_id, u.username, u.first_name, u.last_name, u.bio, u.profile_picture, u.profile_status
       FROM followers f1
       JOIN followers f2 ON f1.followed_user_id = f2.follower_user_id AND f1.follower_user_id = f2.followed_user_id
       JOIN users u ON u.user_id = f1.followed_user_id
       WHERE f1.follower_user_id = ? AND f1.followed_user_id != ?
       ORDER BY u.username`,
      [req.userId, req.userId]
    );
    res.json(
      rows.map((u) => ({
        userId: u.user_id,
        username: u.username,
        firstName: u.first_name,
        lastName: u.last_name,
        bio: u.bio,
        profilePicture: u.profile_picture,
        profileStatus: u.profile_status,
      }))
    );
  } catch (err) {
    console.error('Get mutual connections error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// GET /api/users/:id
router.get('/:id', authenticateToken, async (req, res) => {
  try {
    const userId = parseInt(req.params.id, 10);
    if (!userId) {
      return res.status(400).json({ error: 'Invalid user id' });
    }
    const user = await buildUserProfile(userId, { viewerId: req.userId });
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    if (user.profile_status === 'private' && !user.isFollowing && userId !== req.userId) {
      delete user.email;
      user.travelPhotos = [];
      user.travelPhotoIds = [];
      user.isPrivate = true;
    } else {
      user.isPrivate = false;
    }
    res.json(user);
  } catch (err) {
    console.error('Get user error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/users/:id/follow
router.post('/:id/follow', authenticateToken, async (req, res) => {
  try {
    const followedUserId = parseInt(req.params.id, 10);
    if (!followedUserId || followedUserId === req.userId) {
      return res.status(400).json({ error: 'Invalid user id' });
    }
    const [existing] = await pool.query(
      'SELECT user_id FROM users WHERE user_id = ?', [followedUserId]
    );
    if (existing.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    await pool.query(
      'INSERT IGNORE INTO followers (follower_user_id, followed_user_id) VALUES (?, ?)',
      [req.userId, followedUserId]
    );
    res.json({ success: true, following: true });
  } catch (err) {
    console.error('Follow user error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/users/:id/follow
router.delete('/:id/follow', authenticateToken, async (req, res) => {
  try {
    const followedUserId = parseInt(req.params.id, 10);
    if (!followedUserId) {
      return res.status(400).json({ error: 'Invalid user id' });
    }
    await pool.query(
      'DELETE FROM followers WHERE follower_user_id = ? AND followed_user_id = ?',
      [req.userId, followedUserId]
    );
    res.json({ success: true, following: false });
  } catch (err) {
    console.error('Unfollow user error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
