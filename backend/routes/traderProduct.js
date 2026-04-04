const express = require('express');
const router = express.Router();
const {
  createTraderProduct,
  getTraderProducts,
  getTraderProductById,
  updateTraderProductStatus,
} = require('../controllers/traderProductController');

// All handlers must be functions
router.post('/', createTraderProduct);
router.get('/trader/:trader_id', getTraderProducts);
router.get('/:id', getTraderProductById);
router.put('/:id/status', updateTraderProductStatus);

module.exports = router;
