const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Debug: Check if authController is loaded correctly
console.log('🔍 DEBUG: authController loaded:', typeof authController);
console.log('🔍 DEBUG: authController.login:', typeof authController.login);

// Unified login for all roles
router.post('/login', authController.login);

module.exports = router;
