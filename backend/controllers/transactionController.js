const db = require('../db');

// Create a new transaction
exports.createTransaction = async (req, res) => {
  const { seller_id, seller_type, buyer_id, buyer_type, product_id, order_id, quantity, unit_price, total_revenue, status } = req.body;

  try {
    const result = await db.query(
      `INSERT INTO public.transactions 
        (seller_id, seller_type, buyer_id, buyer_type, product_id, order_id, quantity, unit_price, total_revenue, status) 
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, COALESCE($10, 'initiated')) 
       RETURNING *`,
      [
        seller_id || null, 
        seller_type || null, 
        buyer_id || null, 
        buyer_type || null, 
        product_id || null, 
        order_id || null, 
        quantity || null, 
        unit_price || null, 
        total_revenue || null, 
        status || null
      ]
    );

    res.status(201).json({
      success: true,
      message: 'Transaction created successfully',
      transaction: result.rows[0]
    });
  } catch (error) {
    console.error('Create Transaction Error:', error);
    res.status(500).json({ success: false, error: 'Failed to create transaction' });
  }
};

// Get all transactions
exports.getAllTransactions = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.transactions ORDER BY transaction_date DESC');
    res.status(200).json({
      success: true,
      count: result.rowCount,
      transactions: result.rows
    });
  } catch (error) {
    console.error('Get All Transactions Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch transactions' });
  }
};

// Get single transaction by ID
exports.getTransactionById = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.query('SELECT * FROM public.transactions WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Transaction not found' });
    }

    res.status(200).json({
      success: true,
      transaction: result.rows[0]
    });
  } catch (error) {
    console.error('Get Transaction By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch transaction' });
  }
};

// Update a transaction by ID
exports.updateTransaction = async (req, res) => {
  const { id } = req.params;
  const { seller_id, seller_type, buyer_id, buyer_type, product_id, order_id, quantity, unit_price, total_revenue, status } = req.body;

  try {
    // Check if transaction exists
    const checkTransaction = await db.query('SELECT * FROM public.transactions WHERE id = $1', [id]);
    if (checkTransaction.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Transaction not found' });
    }

    const result = await db.query(
      `UPDATE public.transactions 
       SET 
         seller_id = COALESCE($1, seller_id),
         seller_type = COALESCE($2, seller_type),
         buyer_id = COALESCE($3, buyer_id),
         buyer_type = COALESCE($4, buyer_type),
         product_id = COALESCE($5, product_id),
         order_id = COALESCE($6, order_id),
         quantity = COALESCE($7, quantity),
         unit_price = COALESCE($8, unit_price),
         total_revenue = COALESCE($9, total_revenue),
         status = COALESCE($10, status)
       WHERE id = $11 
       RETURNING *`,
      [
        seller_id || null, 
        seller_type || null, 
        buyer_id || null, 
        buyer_type || null, 
        product_id || null, 
        order_id || null, 
        quantity || null, 
        unit_price || null, 
        total_revenue || null, 
        status || null, 
        id
      ]
    );

    res.status(200).json({
      success: true,
      message: 'Transaction updated successfully',
      transaction: result.rows[0]
    });
  } catch (error) {
    console.error('Update Transaction Error:', error);
    res.status(500).json({ success: false, error: 'Failed to update transaction' });
  }
};

// Delete a transaction by ID
exports.deleteTransaction = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.query('DELETE FROM public.transactions WHERE id = $1 RETURNING *', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Transaction not found' });
    }

    res.status(200).json({
      success: true,
      message: 'Transaction deleted successfully'
    });
  } catch (error) {
    console.error('Delete Transaction Error:', error);
    res.status(500).json({ success: false, error: 'Failed to delete transaction' });
  }
};
