require('dotenv').config({ path: require('path').join(__dirname, '.env') });
if (!process.env.JWT_SECRET) {
  console.error('FATAL: JWT_SECRET is not configured — set it in backend/.env (see .env.example)');
  process.exit(1);
}
if (!process.env.DB_HOST || !process.env.DB_USER || !process.env.DB_PASSWORD || !process.env.DB_NAME) {
  console.error('FATAL: DB_HOST/DB_USER/DB_PASSWORD/DB_NAME are not configured — set them in backend/.env (see .env.example)');
  process.exit(1);
}

const express = require('express');
const cors = require('cors');
const path = require('path');

const authRoutes = require('./routes/auth');
const countryRoutes = require('./routes/countries');
const placeRoutes = require('./routes/places');
const tripRoutes = require('./routes/trips');
const journalRoutes = require('./routes/journal');
const wishlistRoutes = require('./routes/wishlist');
const visitedRoutes = require('./routes/visited');
const profileRoutes = require('./routes/profile');
const ticketRoutes = require('./routes/ticketScans');
const ratingRoutes = require('./routes/ratings');
const settingsRoutes = require('./routes/settings');
const aiRoutes = require('./routes/ai');
const userRoutes = require('./routes/users');
const uploadsRoutes = require('./routes/uploads');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json({ limit: '2mb' }));
app.use('/api', (req, res, next) => {
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  next();
});

app.use('/uploads', uploadsRoutes);

app.use('/api/auth', authRoutes);
app.use('/api/countries', countryRoutes);
app.use('/api/places', placeRoutes);
app.use('/api/trips', tripRoutes);
app.use('/api/journal', journalRoutes);
app.use('/api/wishlist', wishlistRoutes);
app.use('/api/visited', visitedRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/tickets', ticketRoutes);
app.use('/api/ratings', ratingRoutes);
app.use('/api/settings', settingsRoutes);
app.use('/api/ai', aiRoutes);
app.use('/api/users', userRoutes);

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.listen(PORT, () => {
  console.log(`PinMap API running on http://localhost:${PORT}`);
});
