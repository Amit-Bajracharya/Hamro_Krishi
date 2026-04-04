const express = require('express');
const cors = require('cors');
require('dotenv').config();
const db = require('./db');
const middlemenRoutes = require('./routes/middlemenRoutes');
const productRoutes = require('./routes/productRoutes');

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/middlemen', middlemenRoutes);
app.use('/api/products', productRoutes);

app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Hamro Krishi API' });
});

app.get('/api/test-db', async (req, res) => {
  try {
    // Simple test to see if PostgreSQL connects successfully
    const result = await db.query('SELECT NOW()');
    res.json({ 
      success: true, 
      message: 'Direct PostgreSQL connection to Supabase is successful!',
      time: result.rows[0].now
    });
  } catch (error) {
    console.error('Database Connection Error:', error);
    res.status(500).json({ success: false, error: 'Failed to connect to the database via pg' });
  }
});

// Start Server
app.listen(port, () => {
  console.log(`🚀 Server running on http://localhost:${port}`);
});
