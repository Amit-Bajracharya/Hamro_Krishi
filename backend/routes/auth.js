const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Unified login for all roles
router.post('/login', authController.login);

module.exports = router;
