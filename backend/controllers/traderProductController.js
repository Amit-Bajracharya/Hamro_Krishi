const db = require('../db');

// POST /api/trader-products
exports.createTraderProduct = async (req, res) => {
  const { contract_id, quantity_for_sale, latitude, longitude } = req.body;

  if (!contract_id || !quantity_for_sale || !latitude || !longitude) {
    return res.status(400).json({ success: false, error: 'contract_id, quantity_for_sale, latitude, longitude are required' });
  }

  try {
    const result = await db.query(
      `INSERT INTO public.trader_product (contract_id, quantity_for_sale, latitude, longitude)
       VALUES ($1, $2, $3, $4) RETURNING *`,
      [contract_id, quantity_for_sale, latitude, longitude]
    );
    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Trader Product Error:', error);
    if (error.code === '23503') {
      return res.status(404).json({ success: false, error: 'Referenced contract does not exist.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating trader product.' });
  }
};

// GET /api/trader-products
exports.getAllTraderProducts = async (req, res) => {
  try {
    const query = `
      SELECT tp.*, 
             c.trader_selling_price AS selling_price,
             p.name AS product_name, p.category, p.harvest_date, p.expiry_date,
             m.business_name AS trader_business, m.name AS trader_name
      FROM public.trader_product tp
      LEFT JOIN public.contracts c ON tp.contract_id = c.id
      LEFT JOIN public.product p ON c.product_id = p.id
      LEFT JOIN public.middlemen m ON c.middleman_id = m.id
      ORDER BY tp.created_at DESC
    `;
    const result = await db.query(query);
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get All Trader Products Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch trader products.' });
  }
};

// GET /api/trader-products/:id
exports.getTraderProductById = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT tp.*, 
             c.trader_selling_price AS selling_price,
             p.name AS product_name, p.category, p.harvest_date, p.expiry_date,
             m.business_name AS trader_business, m.name AS trader_name
       FROM public.trader_product tp
       LEFT JOIN public.contracts c ON tp.contract_id = c.id
       LEFT JOIN public.product p ON c.product_id = p.id
       LEFT JOIN public.middlemen m ON c.middleman_id = m.id
       WHERE tp.id = $1`,
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Trader product not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Trader Product By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch trader product.' });
  }
};

// GET /api/trader-products/trader/:middlemanId
exports.getTraderProductsByTrader = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT tp.*, 
             c.trader_selling_price AS selling_price,
             p.name AS product_name, p.category
       FROM public.trader_product tp
       LEFT JOIN public.contracts c ON tp.contract_id = c.id
       LEFT JOIN public.product p ON c.product_id = p.id
       WHERE c.middleman_id = $1 
       ORDER BY tp.created_at DESC`,
      [req.params.middlemanId]
    );
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get Trader Products By Trader Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch trader products.' });
  }
};

// PUT /api/trader-products/:id
exports.updateTraderProduct = async (req, res) => {
  const { id } = req.params;
  const allowedFields = ['quantity_for_sale', 'latitude', 'longitude', 'status'];
  const updates = [], values = [];
  let i = 1;

  for (const field of allowedFields) {
    if (req.body[field] !== undefined) {
      updates.push(`${field} = $${i++}`);
      values.push(req.body[field]);
    }
  }

  if (updates.length === 0) {
    return res.status(400).json({ success: false, error: 'No valid fields provided for update.' });
  }

  values.push(id);
  try {
    const result = await db.query(
      `UPDATE public.trader_product SET ${updates.join(', ')} WHERE id = $${i} RETURNING *`,
      values
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Trader product not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Update Trader Product Error:', error);
    res.status(500).json({ success: false, error: 'Server error updating trader product.' });
  }
};

// DELETE /api/trader-products/:id
exports.deleteTraderProduct = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.trader_product WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Trader product not found.' });
    }
    res.json({ success: true, message: 'Trader product deleted successfully.' });
  } catch (error) {
    console.error('Delete Trader Product Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting trader product.' });
  }
};
