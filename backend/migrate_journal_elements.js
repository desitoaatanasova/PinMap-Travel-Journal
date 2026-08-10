// One-off migration: add missing columns to journal_elements.
// Idempotent: each column is added only if it does not already exist.
const mysql = require('mysql2/promise');
const pool = require('./db');

const TABLE = 'journal_elements';

const COLUMNS = [
  ['scale', "DOUBLE DEFAULT 1"],
  ['rotation', "DOUBLE DEFAULT 0"],
  ['z_index', "INT NOT NULL DEFAULT 0"],
  ['image_url', "VARCHAR(500) DEFAULT NULL"],
  ['created_at', "DATETIME DEFAULT CURRENT_TIMESTAMP"],
];

async function main() {
  const conn = await pool.getConnection();
  try {
    const [cols] = await conn.query(
      `SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ?`,
      [TABLE]
    );
    const existing = new Set(cols.map((c) => c.COLUMN_NAME));

    for (const [name, definition] of COLUMNS) {
      if (existing.has(name)) {
        console.log(`- ${TABLE}.${name}: already present, skipping`);
        continue;
      }
      await conn.query(`ALTER TABLE \`${TABLE}\` ADD COLUMN \`${name}\` ${definition}`);
      console.log(`+ ${TABLE}.${name}: added (${definition})`);
    }

    const [verify] = await conn.query(
      `SELECT COLUMN_NAME, COLUMN_TYPE, COLUMN_DEFAULT FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = ? ORDER BY ORDINAL_POSITION`,
      [TABLE]
    );
    console.log('\nCurrent journal_elements columns:');
    for (const c of verify) {
      console.log(`  ${c.COLUMN_NAME.padEnd(12)} ${c.COLUMN_TYPE} default=${c.COLUMN_DEFAULT}`);
    }
  } catch (err) {
    console.error('Migration failed:', err.message);
    process.exitCode = 1;
  } finally {
    conn.release();
    await pool.end();
  }
}

main();
