const express = require('express');
const router = express.Router();
const {
  createConsumer,
  getAllConsumers,
  getNearbyConsumers,
  getConsumerById,
  updateConsumer,
  deleteConsumer,
  getConsumerMarketplace,
} = require('../controllers/customerController');

router.get('/marketplace', getConsumerMarketplace); // Price Transparency Feed
router.get('/nearby', getNearbyConsumers); // must be before /:id
router.get('/',       getAllConsumers);
router.post('/',      createConsumer);
router.get('/:id',    getConsumerById);
router.put('/:id',    updateConsumer);
router.delete('/:id', deleteConsumer);

module.exports = router;