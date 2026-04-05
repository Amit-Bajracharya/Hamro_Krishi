const { Pool } = require('pg');
require('dotenv').config();

// Force IPv4 DNS resolution to prevent IPv6 connection issues
const dns = require('dns');
dns.setDefaultResultOrder('ipv4first');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
  // Force IPv4 connection to avoid IPv6 network errors
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  // Force IPv4 family
  family: 4,
});

pool.on('error', (err) => {
  console.error('Unexpected error on idle PostgreSQL client', err);
  process.exit(-1);
});

module.exports = {
  query: (text, params) => pool.query(text, params),
  pool,
};
