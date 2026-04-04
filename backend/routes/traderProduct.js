const express = require('express');
const router = express.Router();
const traderProductController = require('../controllers/traderProductController');

// Routes handling trader products
router.post('/', traderProductController.createTraderProduct);
router.get('/', traderProductController.getAllTraderProducts);
router.get('/:id', traderProductController.getTraderProductById);
router.get('/trader/:traderId', traderProductController.getTraderProductsByTrader);
router.put('/:id', traderProductController.updateTraderProduct);
router.delete('/:id', traderProductController.deleteTraderProduct);

module.exports = router;
