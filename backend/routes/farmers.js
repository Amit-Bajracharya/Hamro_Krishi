const express = require('express');
const router = express.Router();
const farmerController = require('../controllers/farmerController');

// GET  /api/farmers/nearby        — must come BEFORE /:id
router.get('/nearby', farmerController.getNearbyFarmers);

// GET  /api/farmers               — list all (paginated + searchable)
router.get('/', farmerController.getAllFarmers);

// GET  /api/farmers/:id           — single farmer
router.get('/:id', farmerController.getFarmerById);

// POST /api/farmers               — create farmer
router.post('/', farmerController.createFarmer);

// PATCH /api/farmers/:id          — partial update
router.patch('/:id', farmerController.updateFarmer);

// DELETE /api/farmers/:id         — delete farmer
router.delete('/:id', farmerController.deleteFarmer);

module.exports = router;