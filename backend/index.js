const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use('/api/farmers',   require('./routes/farmer'));
app.use('/api/customers', require('./routes/customer'));
app.use('/api/traders',   require('./routes/trader'));
app.use('/api/products',  require('./routes/product'));
app.use('/api/orders',    require('./routes/order'));
app.use('/api/reviews',   require('./routes/review'));
app.use('/api/notifications', require('./routes/notification'));
app.use('/api/predictions',   require('./routes/prediction'));
app.use('/api/trader-products', require('./routes/traderProduct'));

app.get('/', (req, res) => {
  res.json({ message: 'Welcome to Hamro Krishi API' });
});

app.listen(port, () => {
  console.log(`🚀 Server running on http://localhost:${port}`);
});