const express = require('express');
const router = express.Router();
const productController = require('../controllers/productController');

// Route to create a new product
router.post('/', productController.createProduct);

// Route to get all products
router.get('/', productController.getAllProducts);

// Route to get a specific product by ID
router.get('/:id', productController.getProductById);

// Route to update a specific product by ID
router.put('/:id', productController.updateProduct);

// Route to delete a specific product by ID
router.delete('/:id', productController.deleteProduct);

module.exports = router;
