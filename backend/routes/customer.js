const express = require('express');
const router = express.Router();
const {
  getAllCustomers,
  getCustomerById,
  createCustomer,
  replaceCustomer,
  updateCustomer,
  deleteCustomer,
  getNearbyCustomers,
} = require('../controllers/customerController');
const {
  validate,
  createCustomerRules,
  updateCustomerRules,
  uuidParamRules,
  listQueryRules,
} = require('../middleware/validate');

// GET /api/customers/nearby  — must come BEFORE /:id to avoid conflict
router.get('/nearby', getNearbyCustomers);

// GET    /api/customers
router.get('/', listQueryRules, validate, getAllCustomers);

// POST   /api/customers
router.post('/', createCustomerRules, validate, createCustomer);

// GET    /api/customers/:id
router.get('/:id', uuidParamRules, validate, getCustomerById);

// PUT    /api/customers/:id  (full replace)
router.put('/:id', [...uuidParamRules, ...createCustomerRules], validate, replaceCustomer);

// PATCH  /api/customers/:id  (partial update)
router.patch('/:id', [...uuidParamRules, ...updateCustomerRules], validate, updateCustomer);

// DELETE /api/customers/:id
router.delete('/:id', uuidParamRules, validate, deleteCustomer);

module.exports = router;