const express = require('express');
const router = express.Router();
const middlemenController = require('../controllers/middlemenController');

// Route for registering a new middleman
router.post('/register', middlemenController.register);

// Route for logging in a middleman
router.post('/login', middlemenController.login);

module.exports = router;
