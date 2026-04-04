const db = require('../db');

// Create a new contract
exports.createContract = async (req, res) => {
  const { 
    farmer_id, middleman_id, transaction_id, product_id, 
    quantity, farmer_selling_price, trader_selling_price, 
    start_date, status 
  } = req.body;

  try {
    const result = await db.query(
      `INSERT INTO public.contracts 
        (farmer_id, middleman_id, transaction_id, product_id, quantity, farmer_selling_price, trader_selling_price, start_date, status) 
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, COALESCE($9, 'active')) 
       RETURNING *`,
      [
        farmer_id || null, 
        middleman_id || null, 
        transaction_id || null, 
        product_id || null,
        quantity || null,
        farmer_selling_price || null,
        trader_selling_price || null,
        start_date || null, 
        status || null
      ]
    );

    res.status(201).json({
      success: true,
      message: 'Contract created successfully',
      contract: result.rows[0]
    });
  } catch (error) {
    console.error('Create Contract Error:', error);
    res.status(500).json({ success: false, error: 'Failed to create contract' });
  }
};

// Get all contracts
exports.getAllContracts = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.contracts ORDER BY created_at DESC');
    res.status(200).json({
      success: true,
      count: result.rowCount,
      contracts: result.rows
    });
  } catch (error) {
    console.error('Get All Contracts Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch contracts' });
  }
};

// Get single contract by ID
exports.getContractById = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.query('SELECT * FROM public.contracts WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Contract not found' });
    }

    res.status(200).json({
      success: true,
      contract: result.rows[0]
    });
  } catch (error) {
    console.error('Get Contract By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch contract' });
  }
};

// Update a contract by ID
exports.updateContract = async (req, res) => {
  const { id } = req.params;
  const { 
    farmer_id, middleman_id, transaction_id, product_id, 
    quantity, farmer_selling_price, trader_selling_price, 
    start_date, status 
  } = req.body;

  try {
    // Check if contract exists
    const checkContract = await db.query('SELECT * FROM public.contracts WHERE id = $1', [id]);
    if (checkContract.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Contract not found' });
    }

    const result = await db.query(
      `UPDATE public.contracts 
       SET 
         farmer_id = COALESCE($1, farmer_id),
         middleman_id = COALESCE($2, middleman_id),
         transaction_id = COALESCE($3, transaction_id),
         product_id = COALESCE($4, product_id),
         quantity = COALESCE($5, quantity),
         farmer_selling_price = COALESCE($6, farmer_selling_price),
         trader_selling_price = COALESCE($7, trader_selling_price),
         start_date = COALESCE($8, start_date),
         status = COALESCE($9, status),
         updated_at = now()
       WHERE id = $10 
       RETURNING *`,
      [
        farmer_id || null, 
        middleman_id || null, 
        transaction_id || null,
        product_id || null,
        quantity || null,
        farmer_selling_price || null,
        trader_selling_price || null, 
        start_date || null, 
        status || null, 
        id
      ]
    );

    res.status(200).json({
      success: true,
      message: 'Contract updated successfully',
      contract: result.rows[0]
    });
  } catch (error) {
    console.error('Update Contract Error:', error);
    res.status(500).json({ success: false, error: 'Failed to update contract' });
  }
};

// Delete a contract by ID
exports.deleteContract = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.query('DELETE FROM public.contracts WHERE id = $1 RETURNING *', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Contract not found' });
    }

    res.status(200).json({
      success: true,
      message: 'Contract deleted successfully'
    });
  } catch (error) {
    console.error('Delete Contract Error:', error);
    res.status(500).json({ success: false, error: 'Failed to delete contract' });
  }
};
