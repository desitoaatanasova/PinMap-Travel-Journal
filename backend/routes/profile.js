const express = require('express');
const path = require('path');
const fs = require('fs');
const fsp = require('fs/promises');
const multer = require('multer');
const pool = require('../db');
const { authenticateToken } = require('../middleware/auth');
const { buildUserProfile } = require('../services/profileQueries');

const router = express.Router();

const UPLOADS_ROOT = path.join(__dirname, '..', 'uploads');

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 20 * 1024 * 1024 },
});

function extFromMime(mime) {
  if (!mime) return '.jpg';
  if (mime.includes('jpeg') || mime.includes('jpg')) return '.jpg';
  if (mime.includes('png')) return '.png';
  if (mime.includes('webp')) return '.webp';
  if (mime.includes('gif')) return '.gif';
  return '.jpg';
}

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
    const user = await buildUserProfile(req.userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (err) {
    console.error('Update profile error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

router.get('/', authenticateToken, async (req, res) => {
  try {
    const user = await buildUserProfile(req.userId);
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (err) {
    console.error('Get profile error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// POST /api/profile/photos  (multipart: field "photo")
router.post('/photos', authenticateToken, upload.single('photo'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'A photo file is required' });
    }
    const dir = path.join(UPLOADS_ROOT, String(req.userId), 'profile');
    await fsp.mkdir(dir, { recursive: true });
    const ext = extFromMime(req.file.mimetype);
    const name = `photo_${Date.now()}${ext}`;
    await fsp.writeFile(path.join(dir, name), req.file.buffer);

    const imageUrl = `/uploads/${req.userId}/profile/${name}`;
    const [result] = await pool.query(
      'INSERT INTO user_photos (user_id, image_url) VALUES (?, ?)',
      [req.userId, imageUrl]
    );

    const user = await buildUserProfile(req.userId);
    res.status(201).json({
      photoId: result.insertId,
      imageUrl,
      travelPhotos: user.travelPhotos,
    });
  } catch (err) {
    console.error('Upload profile photo error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

// DELETE /api/profile/photos/:photoId
router.delete('/photos/:photoId', authenticateToken, async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT image_url FROM user_photos WHERE photo_id = ? AND user_id = ?',
      [req.params.photoId, req.userId]
    );
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Photo not found' });
    }
    await pool.query(
      'DELETE FROM user_photos WHERE photo_id = ? AND user_id = ?',
      [req.params.photoId, req.userId]
    );
    const fileUrl = rows[0].image_url;
    if (fileUrl && fileUrl.startsWith('/uploads/')) {
      const filePath = path.join(UPLOADS_ROOT, fileUrl.replace('/uploads/', ''));
      fs.promises.unlink(filePath).catch(() => {});
    }
    res.json({ success: true });
  } catch (err) {
    console.error('Delete profile photo error:', err);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
