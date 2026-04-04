const express = require('express');
const router = express.Router();
const {
  createProduct,
  getAllProducts,
  getProductById,
  getProductsByFarmer,
  updateProduct,
  deleteProduct,
} = require('../controllers/productController');

router.get('/farmer/:farmer_id', getProductsByFarmer); // before /:id
router.get('/',                  getAllProducts);
router.post('/',                 createProduct);
router.get('/:id',               getProductById);
router.put('/:id',               updateProduct);
router.delete('/:id',            deleteProduct);

module.exports = router;