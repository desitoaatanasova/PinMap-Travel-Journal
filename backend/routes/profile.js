const express = require('express');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

router.put('/', authenticateToken, async (req, res) => {
  try {
    const { firstName, lastName, bio, profilePicture, profileStatus } = req.body;
    const sets = [];
    const params = [];
    if (typeof firstName === 'string') {
      sets.push('first_name = ?');
      params.push(firstName);
    }
    if (typeof lastName === 'string') {
      sets.push('last_name = ?');
      params.push(lastName);
    }
    if (typeof bio === 'string') {
      sets.push('bio = ?');
      params.push(bio);
    }
    if (typeof profilePicture === 'string') {
      sets.push('profile_picture = ?');
      params.push(profilePicture);
    }
    if (profileStatus === 'public' || profileStatus === 'private') {
      sets.push('profile_status = ?');
      params.push(profileStatus);
    }
    if (sets.length > 0) {
      params.push(req.userId);
      await pool.query(`UPDATE users SET ${sets.join(', ')} WHERE user_id = ?`, params);
    }
    const [rows] = await pool.query(
      `SELECT user_id, username, email, first_name, last_name, bio, profile_picture, profile_status, created_at
       FROM users WHERE user_id = ?`,
      [req.userId]
    );
    if (rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    const user = rows[0];
    user.firstName = user.first_name;
    user.lastName = user.last_name;
    res.json(user);
  } catch (err) {
    console.error('Update profile error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT user_id, username, email, first_name, last_name, bio, profile_picture, profile_status, created_at
       FROM users WHERE user_id = ?`,
      [req.userId]
    );
    if (rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    const user = rows[0];

    const [photos] = await pool.query(
      'SELECT image_url FROM user_photos WHERE user_id = ? ORDER BY uploaded_at DESC', [req.userId]
    );
    user.travelPhotos = photos.map(p => p.image_url);

    const [visited] = await pool.query(
      'SELECT COUNT(*) AS cnt FROM visited_places WHERE user_id = ?', [req.userId]
    );
    user.placesVisited = visited[0].cnt;

    const [ratingsCount] = await pool.query(
      'SELECT COUNT(*) AS cnt FROM ratings WHERE user_id = ?', [req.userId]
    );
    user.ratingsGiven = ratingsCount[0].cnt;

    const [tripsCount] = await pool.query(
      'SELECT COUNT(*) AS cnt FROM trips WHERE user_id = ?', [req.userId]
    );
    user.tripsPlanned = tripsCount[0].cnt;

    const [journalsCount] = await pool.query(
      'SELECT COUNT(*) AS cnt FROM journals WHERE user_id = ?', [req.userId]
    );
    user.journalsCreated = journalsCount[0].cnt;

    const [followersCount] = await pool.query(
      'SELECT COUNT(*) AS cnt FROM followers WHERE followed_user_id = ?', [req.userId]
    );
    user.followersCount = followersCount[0].cnt;

    const [followingCount] = await pool.query(
      'SELECT COUNT(*) AS cnt FROM followers WHERE follower_user_id = ?', [req.userId]
    );
    user.followingCount = followingCount[0].cnt;

    res.json(user);
  } catch (err) {
    console.error('Get profile error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
