const db = require('../db');

// POST /api/orders
exports.createOrder = async (req, res) => {
  const { buyer_id, product_id, quantity, price, buyer_type, seller_id, seller_type } = req.body;

  if (!buyer_id || !quantity || !price || !buyer_type || !seller_id || !seller_type) {
    return res.status(400).json({ success: false, error: 'buyer_id, quantity, price, buyer_type, seller_id, seller_type are required' });
  }

  if (!['middleman', 'customer'].includes(buyer_type)) {
    return res.status(400).json({ success: false, error: 'buyer_type must be middleman or customer' });
  }

  if (!['farmer', 'middleman'].includes(seller_type)) {
    return res.status(400).json({ success: false, error: 'seller_type must be farmer or middleman' });
  }

  const client = await db.pool.connect();
  try {
    await client.query('BEGIN');

    // 1. Create Order (Status pending by default as per DB schema)
    const orderResult = await client.query(
      `INSERT INTO public.orders (buyer_id, product_id, quantity, price, buyer_type)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [buyer_id, product_id || null, quantity, price, buyer_type]
    );
    
    const newOrder = orderResult.rows[0];

    // Note: Transaction and inventory deduction will happen later when order is accepted.

    await client.query('COMMIT');
    console.log('Order created successfully:', { orderId: newOrder.id });
    res.status(201).json({ success: true, order: newOrder });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Create Order Error:', error);
    console.error('Error details:', { code: error.code, message: error.message, detail: error.detail });
    if (error.code === '23503') {
      return res.status(404).json({ success: false, error: 'Referenced product, buyer, or seller does not exist.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating order.', details: error.message });
  } finally {
    client.release();
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

// GET /api/orders/seller/:seller_id
exports.getOrdersBySeller = async (req, res) => {
  try {
    console.log('getOrdersBySeller: Fetching orders for farmer_id:', req.params.seller_id);
    
    const result = await db.query(
      `SELECT o.*, p.name AS product_name, p.farmer_id, 
        CASE 
          WHEN o.buyer_type = 'customer' THEN (SELECT c.name FROM public.customers c WHERE c.id = o.buyer_id)
          WHEN o.buyer_type = 'middleman' THEN (SELECT m.name FROM public.middlemen m WHERE m.id = o.buyer_id)
          ELSE 'Unknown' 
        END AS buyer_name
       FROM public.orders o
       LEFT JOIN public.product p ON o.product_id = p.id
       WHERE p.farmer_id = $1
       ORDER BY o.created_at DESC`,
      [req.params.seller_id]
    );
    
    console.log('getOrdersBySeller: Found', result.rowCount, 'orders');
    console.log('getOrdersBySeller: Orders data:', result.rows);
    
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get Orders By Seller Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch orders.' });
  }
};

// POST /api/orders/:id/accept
exports.acceptOrder = async (req, res) => {
  const { id } = req.params;
  const client = await db.pool.connect();
  
  try {
    await client.query('BEGIN');
    
    // 1. Update order status
    const orderResult = await client.query(
      `UPDATE public.orders SET status = 'completed' WHERE id = $1 AND status = 'pending' RETURNING *`,
      [id]
    );
    
    if (orderResult.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({ success: false, error: 'Pending order not found or already processed.' });
    }
    
    const order = orderResult.rows[0];
    
    // 2. Fetch product details to determine seller
    const productResult = await client.query(`SELECT * FROM public.product WHERE id = $1`, [order.product_id]);
    if (productResult.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({ success: false, error: 'Product not found.' });
    }
    const product = productResult.rows[0];
    
    // Determine seller
    let seller_id = product.farmer_id;
    let seller_type = 'farmer';
    
    const totalRevenue = order.quantity * order.price;

    // 3. Create Transaction record
    const transactionResult = await client.query(
      `INSERT INTO public.transactions (seller_id, seller_type, buyer_id, buyer_type, product_id, order_id, quantity, unit_price, total_revenue, status)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, 'completed') RETURNING *`,
      [seller_id, seller_type, order.buyer_id, order.buyer_type, product.id, order.id, order.quantity, order.price, totalRevenue]
    );

    // 4. Decrement Product Inventory
    await client.query(
      `UPDATE public.product SET quantity = quantity - $1 WHERE id = $2`,
      [order.quantity, product.id]
    );

    await client.query('COMMIT');
    res.json({ success: true, message: 'Order accepted successfully', transaction: transactionResult.rows[0], order: order });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Accept Order Error:', error);
    res.status(500).json({ success: false, error: 'Failed to accept order.' });
  } finally {
    client.release();
  }
};