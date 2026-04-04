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

const farmersRouter = require('./routes/farmers');
app.use('/api/farmers', farmersRouter);


// Start Server
app.listen(port, () => {
  console.log(`🚀 Server running on http://localhost:${port}`);
});
