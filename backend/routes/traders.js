const express = require('express');
const router = express.Router();
const {
  createTrader,
  getAllTraders,
  getTraderById,
  updateTrader,
  deleteTrader,
} = require('../controllers/traderController');

router.get('/',       getAllTraders);
router.post('/',      createTrader);
router.get('/:id',    getTraderById);
router.put('/:id',    updateTrader);
router.delete('/:id', deleteTrader);

module.exports = router;