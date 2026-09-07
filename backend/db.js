const mysql = require('mysql2/promise');

for (const k of ['DB_HOST', 'DB_USER', 'DB_PASSWORD', 'DB_NAME']) {
  if (!process.env[k]) throw new Error(`${k} is not configured — set it in backend/.env (see .env.example)`);
}
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT || '3306', 10),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  charset: process.env.DB_CHARSET || 'utf8mb4',
  waitForConnections: true,
  connectionLimit: parseInt(process.env.DB_POOL_LIMIT || '20', 10),
  queueLimit: parseInt(process.env.DB_QUEUE_LIMIT || '50', 10),
  enableKeepAlive: true,
  keepAliveInitialDelay: 10000,
});

module.exports = pool;
