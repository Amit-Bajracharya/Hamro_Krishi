const db = require('../db');

// POST /api/orders
exports.createOrder = async (req, res) => {
  const { buyer_id, product_id, quantity, price, buyer_type } = req.body;

  if (!buyer_id || !quantity || !price || !buyer_type) {
    return res.status(400).json({ success: false, error: 'buyer_id, quantity, price, buyer_type are required' });
  }

  if (!['middleman', 'customer'].includes(buyer_type)) {
    return res.status(400).json({ success: false, error: 'buyer_type must be middleman or customer' });
  }

  try {
    const result = await db.query(
      `INSERT INTO public.orders (buyer_id, product_id, quantity, price, buyer_type)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [buyer_id, product_id || null, quantity, price, buyer_type]
    );
    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Order Error:', error);
    if (error.code === '23503') {
      return res.status(404).json({ success: false, error: 'Referenced product does not exist.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating order.' });
  }
};

// GET /api/orders
exports.getAllOrders = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT o.*, p.name AS product_name
       FROM public.orders o
       LEFT JOIN public.product p ON o.product_id = p.id
       ORDER BY o.created_at DESC`
    );
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get All Orders Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch orders.' });
  }
};

// GET /api/orders/:id
exports.getOrderById = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT o.*, p.name AS product_name
       FROM public.orders o
       LEFT JOIN public.product p ON o.product_id = p.id
       WHERE o.id = $1`,
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Order not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Order By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch order.' });
  }
};

// GET /api/orders/buyer/:buyer_id
exports.getOrdersByBuyer = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT o.*, p.name AS product_name
       FROM public.orders o
       LEFT JOIN public.product p ON o.product_id = p.id
       WHERE o.buyer_id = $1
       ORDER BY o.created_at DESC`,
      [req.params.buyer_id]
    );
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get Orders By Buyer Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch orders.' });
  }
};

// PATCH /api/orders/:id/status
exports.updateOrderStatus = async (req, res) => {
  const { status } = req.body;

  if (!status) {
    return res.status(400).json({ success: false, error: 'status is required' });
  }

  if (!['pending', 'completed', 'cancelled'].includes(status)) {
    return res.status(400).json({ success: false, error: 'status must be pending, completed, or cancelled' });
  }

  try {
    const result = await db.query(
      `UPDATE public.orders SET status = $1 WHERE id = $2 RETURNING *`,
      [status, req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Order not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Update Order Status Error:', error);
    res.status(500).json({ success: false, error: 'Server error updating order status.' });
  }
};

// DELETE /api/orders/:id
exports.deleteOrder = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.orders WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Order not found.' });
    }
    res.json({ success: true, message: 'Order deleted successfully.' });
  } catch (error) {
    console.error('Delete Order Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting order.' });
  }
};