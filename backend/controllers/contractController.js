const db = require('../db');

// Create a new contract
exports.createContract = async (req, res) => {
  const { 
    farmer_id, middleman_id, product_id, 
    quantity, farmer_selling_price, trader_selling_price, 
    start_date, status 
  } = req.body;

  try {
    const result = await db.query(
      `INSERT INTO public.contracts 
        (farmer_id, middleman_id, product_id, quantity, farmer_selling_price, trader_selling_price, start_date, status) 
       VALUES ($1, $2, $3, $4, $5, $6, $7, COALESCE($8, 'active')) 
       RETURNING *`,
      [
        farmer_id || null, 
        middleman_id || null, 
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

// Get contracts by user ID and role
exports.getContractsByUser = async (req, res) => {
  const { userId } = req.params;
  const { role } = req.query;

  try {
    let query;
    if (role === 'farmer') {
      query = `
        SELECT c.*, m.name AS trader_name, p.name AS product_name
        FROM public.contracts c
        LEFT JOIN public.middlemen m ON c.middleman_id = m.id
        LEFT JOIN public.product p ON c.product_id = p.id
        WHERE c.farmer_id = $1 
        ORDER BY c.created_at DESC`;
    } else if (role === 'trader' || role === 'middleman') {
      query = `
        SELECT c.*, f.name AS farmer_name, p.name AS product_name
        FROM public.contracts c
        LEFT JOIN public.farmers f ON c.farmer_id = f.id
        LEFT JOIN public.product p ON c.product_id = p.id
        WHERE c.middleman_id = $1 
        ORDER BY c.created_at DESC`;
    } else {
      return res.status(400).json({ success: false, error: 'Invalid role provided' });
    }

    const result = await db.query(query, [userId]);
    res.status(200).json({
      success: true,
      count: result.rowCount,
      contracts: result.rows
    });
  } catch (error) {
    console.error('Get User Contracts Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch user contracts' });
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
    farmer_id, middleman_id, product_id, 
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
         product_id = COALESCE($3, product_id),
         quantity = COALESCE($4, quantity),
         farmer_selling_price = COALESCE($5, farmer_selling_price),
         trader_selling_price = COALESCE($6, trader_selling_price),
         start_date = COALESCE($7, start_date),
         status = COALESCE($8, status),
         updated_at = now()
       WHERE id = $9 
       RETURNING *`,
      [
        farmer_id || null, 
        middleman_id || null, 
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

// Update contract status (e.g., Accept/Decline)
exports.updateContractStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  if (!['pending', 'active', 'declined', 'expired', 'terminated'].includes(status)) {
    return res.status(400).json({ success: false, error: 'Invalid status' });
  }

  const client = await db.pool.connect();

  try {
    await client.query('BEGIN');

    // 1. Update contract status
    const contractResult = await client.query(
      `UPDATE public.contracts 
       SET status = $1, updated_at = now() 
       WHERE id = $2 
       RETURNING *`,
      [status, id]
    );

    if (contractResult.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({ success: false, error: 'Contract not found' });
    }

    const updatedContract = contractResult.rows[0];

    // 2. If contract is signed (active), handle inventory
    if (status === 'active') {
      const { product_id, quantity: contractQuantity } = updatedContract;

      // Decrement product quantity
      const productResult = await client.query(
        `UPDATE public.product 
         SET quantity = quantity - $1 
         WHERE id = $2 
         RETURNING quantity`,
        [contractQuantity, product_id]
      );

      if (productResult.rows.length > 0) {
        const newQuantity = parseFloat(productResult.rows[0].quantity);

        // 3. If quantity is 0 or less, remove product
        if (newQuantity <= 0) {
          await client.query(
            'DELETE FROM public.product WHERE id = $1',
            [product_id]
          );
          console.log(`Product ${product_id} exhausted and removed from marketplace.`);
        }
      }
    }

    await client.query('COMMIT');

    res.status(200).json({
      success: true,
      message: `Contract status updated to ${status}${status === 'active' ? ' and inventory updated' : ''}`,
      contract: updatedContract
    });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Update Contract Status Transaction Error:', error);
    res.status(500).json({ success: false, error: 'Failed to update contract status' });
  } finally {
    client.release();
  }
};
