const db = require('../db');

// POST /api/products
exports.createProduct = async (req, res) => {
  const { name, category, harvest_date, expiry_date, price, quantity, farmer_id, latitude, longitude, image_url } = req.body;

  if (!name || !category || !expiry_date || !price || !quantity || latitude === undefined || longitude === undefined) {
    return res.status(400).json({ success: false, error: 'name, category, expiry_date, price, quantity, latitude, and longitude are required' });
  }

  if (!['vegetable', 'fruit', 'grain'].includes(category)) {
    return res.status(400).json({ success: false, error: 'category must be vegetable, fruit, or grain' });
  }

  try {
    const result = await db.query(
      `INSERT INTO public.product (name, category, harvest_date, expiry_date, price, quantity, farmer_id, latitude, longitude, image_url)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING *`,
      [name, category, harvest_date || null, expiry_date, price, quantity, farmer_id || null, latitude, longitude, image_url || null]
    );
    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Product Error:', error);
    if (error.code === '23503') {
      return res.status(404).json({ success: false, error: 'Referenced farmer does not exist.' });
    }
    if (error.code === '23514') {
      return res.status(400).json({ success: false, error: 'expiry_date must be greater than or equal to harvest_date and category must be valid.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating product.' });
  }
};


// GET /api/products
exports.getAllProducts = async (req, res) => {
  const { category } = req.query;

  try {
    let query = `SELECT p.*, f.name AS farmer_name
                 FROM public.product p
                 LEFT JOIN public.farmers f ON p.farmer_id = f.id`;
    const values = [];

    if (category) {
      query += ' WHERE p.category = $1';
      values.push(category);
    }

    query += ' ORDER BY p.created_at DESC';

    const result = await db.query(query, values);
    
    // Debug: Check if price is null
    console.log('getAllProducts: Returning', result.rowCount, 'products');
    if (result.rows.length > 0) {
      console.log('getAllProducts: First product price:', result.rows[0].price);
      console.log('getAllProducts: First product fields:', Object.keys(result.rows[0]));
    }
    
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get All Products Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch products.' });
  }
};

// GET /api/products/:id
exports.getProductById = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT p.*, f.name AS farmer_name
       FROM public.product p
       LEFT JOIN public.farmers f ON p.farmer_id = f.id
       WHERE p.id = $1`,
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Product not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Product By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch product.' });
  }
};

// GET /api/products/farmer/:farmer_id
exports.getProductsByFarmer = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT * FROM public.product WHERE farmer_id = $1 ORDER BY created_at DESC`,
      [req.params.farmer_id]
    );
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get Products By Farmer Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch products.' });
  }
};

// PUT /api/products/:id
exports.updateProduct = async (req, res) => {
  const { id } = req.params;
  const allowedFields = ['name', 'category', 'harvest_date', 'expiry_date', 'price', 'quantity', 'latitude', 'longitude'];
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

  if (req.body.category && !['vegetable', 'fruit', 'grain'].includes(req.body.category)) {
    return res.status(400).json({ success: false, error: 'category must be vegetable, fruit, or grain' });
  }

  values.push(id);
  try {
    const result = await db.query(
      `UPDATE public.product SET ${updates.join(', ')} WHERE id = $${i} RETURNING *`,
      values
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Product not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Update Product Error:', error);
    if (error.code === '23514') {
      return res.status(400).json({ success: false, error: 'expiry_date must be greater than or equal to harvest_date.' });
    }
    res.status(500).json({ success: false, error: 'Server error updating product.' });
  }
};

// DELETE /api/products/:id
exports.deleteProduct = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.product WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Product not found.' });
    }
    res.json({ success: true, message: 'Product deleted successfully.' });
  } catch (error) {
    console.error('Delete Product Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting product.' });
  }
};