const { Pool } = require('pg');
const dns = require('dns');
const { promisify } = require('util');
require('dotenv').config();

const resolve4 = promisify(dns.resolve4);

async function createPool() {
  const connectionString = process.env.DATABASE_URL;
  if (!connectionString) throw new Error('DATABASE_URL is not defined');

  const dbUrl = new URL(connectionString);
  let host = dbUrl.hostname;

  try {
    // Try to manually resolve host to IPv4
    const addresses = await resolve4(host);
    if (addresses.length > 0) {
      host = addresses[0];
      console.log(`📡 Resolved ${dbUrl.hostname} to IPv4: ${host}`);
    }
  } catch (err) {
    console.warn(`⚠️ DNS Resolution failed for ${host}, using hostname directly.`, err.message);
  }

  return new Pool({
    user: dbUrl.username,
    password: decodeURIComponent(dbUrl.password),
    host: host,
    port: dbUrl.port,
    database: dbUrl.pathname.split('/')[1],
    ssl: { rejectUnauthorized: false },
  });
}

// Export a wrapper that ensures the pool is ready
let poolInstance;
const query = async (text, params) => {
  if (!poolInstance) poolInstance = await createPool();
  return poolInstance.query(text, params);
};

module.exports = {
  query,
  getPool: async () => {
    if (!poolInstance) poolInstance = await createPool();
    return poolInstance;
  }
};
