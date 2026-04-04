const express = require('express');
const router = express.Router();
const {
  createFarmer,
  getAllFarmers,
  getFarmerById,
  updateFarmer,
  deleteFarmer,
} = require('../controllers/farmerController');

router.get('/',       getAllFarmers);
router.post('/',      createFarmer);
router.get('/:id',    getFarmerById);
router.put('/:id',    updateFarmer);
router.delete('/:id', deleteFarmer);

module.exports = router;