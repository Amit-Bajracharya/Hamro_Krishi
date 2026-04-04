const express = require('express');
const router = express.Router();
const predictionController = require('../controllers/predictionController');

router.get('/demand', predictionController.predictDemand);

module.exports = router;
