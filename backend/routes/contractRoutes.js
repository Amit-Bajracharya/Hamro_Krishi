const express = require('express');
const router = express.Router();
const contractController = require('../controllers/contractController');

// Route to create a new contract
router.post('/', contractController.createContract);

// Route to get all contracts
router.get('/', contractController.getAllContracts);

// Route to get a specific contract by ID
router.get('/:id', contractController.getContractById);

// Route to update a specific contract by ID
router.put('/:id', contractController.updateContract);

// Route to delete a specific contract by ID
router.delete('/:id', contractController.deleteContract);

module.exports = router;
