const express = require('express');
const router = express.Router();
const predictionController = require('../controllers/predictionController');

router.get('/dashboard', predictionController.getDashboardPredictions);

module.exports = router;
