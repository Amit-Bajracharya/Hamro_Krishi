const db = require('../db');

// Create a new contract
exports.createContract = async (req, res) => {
  const { farmer_id, middleman_id, transaction_id, contract_terms, financial_security, revenue_share, jurisdiction, start_date, end_date, status } = req.body;

  try {
    const result = await db.query(
      `INSERT INTO public.contracts 
        (farmer_id, middleman_id, transaction_id, contract_terms, financial_security, revenue_share, jurisdiction, start_date, end_date, status) 
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, COALESCE($10, 'active')) 
       RETURNING *`,
      [
        farmer_id || null, 
        middleman_id || null, 
        transaction_id || null, 
        contract_terms || null, 
        financial_security || null, 
        revenue_share || null, 
        jurisdiction || null, 
        start_date || null, 
        end_date || null, 
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
  const { farmer_id, middleman_id, transaction_id, contract_terms, financial_security, revenue_share, jurisdiction, start_date, end_date, status } = req.body;

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
         contract_terms = COALESCE($4, contract_terms),
         financial_security = COALESCE($5, financial_security),
         revenue_share = COALESCE($6, revenue_share),
         jurisdiction = COALESCE($7, jurisdiction),
         start_date = COALESCE($8, start_date),
         end_date = COALESCE($9, end_date),
         status = COALESCE($10, status),
         updated_at = now()
       WHERE id = $11 
       RETURNING *`,
      [
        farmer_id || null, 
        middleman_id || null, 
        transaction_id || null, 
        contract_terms || null, 
        financial_security || null, 
        revenue_share || null, 
        jurisdiction || null, 
        start_date || null, 
        end_date || null, 
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
