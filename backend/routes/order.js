const express = require('express');
const router = express.Router();
const {
  createOrder,
  getAllOrders,
  getOrderById,
  getOrdersByBuyer,
  updateOrderStatus,
  deleteOrder,
} = require('../controllers/orderController');

router.get('/buyer/:buyer_id', getOrdersByBuyer); // before /:id
router.get('/',                getAllOrders);
router.post('/',               createOrder);
router.get('/:id',             getOrderById);
router.patch('/:id/status',    updateOrderStatus);
router.delete('/:id',          deleteOrder);

module.exports = router;