const pool = require('../db');

/**
 * Aggregates a user's public profile data: basic info, travel photos,
 * visited places, ratings, trips, journals, followers/following counts,
 * and (optionally) whether the requesting user follows them.
 */
async function buildUserProfile(userId, { viewerId = null } = {}) {
  const [rows] = await pool.query(
    `SELECT user_id, username, email, first_name, last_name, bio, profile_picture, profile_status, created_at
     FROM users WHERE user_id = ?`,
    [userId]
  );
  if (rows.length === 0) return null;
  const user = rows[0];

  const [photos] = await pool.query(
    'SELECT photo_id, image_url FROM user_photos WHERE user_id = ? ORDER BY uploaded_at DESC, photo_id DESC',
    [userId]
  );
  user.travelPhotos = photos.map((p) => p.image_url);
  user.travelPhotoIds = photos.map((p) => p.photo_id);

  const [visited] = await pool.query(
    'SELECT COUNT(*) AS cnt FROM visited_places WHERE user_id = ?', [userId]
  );
  user.placesVisited = visited[0].cnt;

  const [ratingsCount] = await pool.query(
    'SELECT COUNT(*) AS cnt FROM ratings WHERE user_id = ?', [userId]
  );
  user.ratingsGiven = ratingsCount[0].cnt;

  const [tripsCount] = await pool.query(
    'SELECT COUNT(*) AS cnt FROM trips WHERE user_id = ?', [userId]
  );
  user.tripsPlanned = tripsCount[0].cnt;

  const [journalsCount] = await pool.query(
    'SELECT COUNT(*) AS cnt FROM journals WHERE user_id = ?', [userId]
  );
  user.journalsCreated = journalsCount[0].cnt;

  const [followersCount] = await pool.query(
    'SELECT COUNT(*) AS cnt FROM followers WHERE followed_user_id = ?', [userId]
  );
  user.followersCount = followersCount[0].cnt;

  const [followingCount] = await pool.query(
    'SELECT COUNT(*) AS cnt FROM followers WHERE follower_user_id = ?', [userId]
  );
  user.followingCount = followingCount[0].cnt;

  user.isFollowing = false;
  if (viewerId && viewerId !== userId) {
    const [rel] = await pool.query(
      'SELECT 1 AS x FROM followers WHERE follower_user_id = ? AND followed_user_id = ?',
      [viewerId, userId]
    );
    user.isFollowing = rel.length > 0;
  }

  user.firstName = user.first_name;
  user.lastName = user.last_name;
  delete user.first_name;
  delete user.last_name;
  return user;
}

module.exports = { buildUserProfile };
