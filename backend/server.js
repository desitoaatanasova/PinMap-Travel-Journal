require('dotenv').config();

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

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

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

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.listen(PORT, () => {
  console.log(`PinMap API running on http://localhost:${PORT}`);
});
