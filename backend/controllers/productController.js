const db = require('../db');

// Create a new product
exports.createProduct = async (req, res) => {
  const { name, category, harvest_date, expiry_date, price, quantity, farmer_id, latitude, longitude } = req.body;

  try {
    const result = await db.query(
      `INSERT INTO public.product 
        (name, category, harvest_date, expiry_date, price, quantity, farmer_id, latitude, longitude) 
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) 
       RETURNING *`,
      [
        name || null, 
        category || null, 
        harvest_date || null, 
        expiry_date || null, 
        price || null, 
        quantity || null, 
        farmer_id || null, 
        latitude || null, 
        longitude || null
      ]
    );

    res.status(201).json({
      success: true,
      message: 'Product created successfully',
      product: result.rows[0]
    });
  } catch (error) {
    console.error('Create Product Error:', error);
    res.status(500).json({ success: false, error: 'Failed to create product' });
  }
};

// Get all products
exports.getAllProducts = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.product ORDER BY created_at DESC');
    res.status(200).json({
      success: true,
      count: result.rowCount,
      products: result.rows
    });
  } catch (error) {
    console.error('Get All Products Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch products' });
  }
};

// Get single product by ID
exports.getProductById = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.query('SELECT * FROM public.product WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Product not found' });
    }

    res.status(200).json({
      success: true,
      product: result.rows[0]
    });
  } catch (error) {
    console.error('Get Product By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch product' });
  }
};

// Update a product by ID
exports.updateProduct = async (req, res) => {
  const { id } = req.params;
  const { name, category, harvest_date, expiry_date, price, quantity, latitude, longitude } = req.body;

  try {
    // Check if product exists
    const checkProduct = await db.query('SELECT * FROM public.product WHERE id = $1', [id]);
    if (checkProduct.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Product not found' });
    }

    const result = await db.query(
      `UPDATE public.product 
       SET 
         name = COALESCE($1, name),
         category = COALESCE($2, category),
         harvest_date = COALESCE($3, harvest_date),
         expiry_date = COALESCE($4, expiry_date),
         price = COALESCE($5, price),
         quantity = COALESCE($6, quantity),
         latitude = COALESCE($7, latitude),
         longitude = COALESCE($8, longitude)
       WHERE id = $9 
       RETURNING *`,
      [
        name || null, 
        category || null, 
        harvest_date || null, 
        expiry_date || null, 
        price || null, 
        quantity || null, 
        latitude || null, 
        longitude || null, 
        id
      ]
    );

    res.status(200).json({
      success: true,
      message: 'Product updated successfully',
      product: result.rows[0]
    });
  } catch (error) {
    console.error('Update Product Error:', error);
    res.status(500).json({ success: false, error: 'Failed to update product' });
  }
};

// Delete a product by ID
exports.deleteProduct = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await db.query('DELETE FROM public.product WHERE id = $1 RETURNING *', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Product not found' });
    }

    res.status(200).json({
      success: true,
      message: 'Product deleted successfully'
    });
  } catch (error) {
    console.error('Delete Product Error:', error);
    res.status(500).json({ success: false, error: 'Failed to delete product' });
  }
};
