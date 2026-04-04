const db = require('../db');

/**
 * Create a new trader product listing from an active contract.
 */
const createTraderProduct = async (req, res) => {
  try {
    const { contract_id, quantity_for_sale, latitude, longitude, status } = req.body;

    if (!contract_id || !quantity_for_sale || !latitude || !longitude) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await db.query(
      `INSERT INTO public.trader_product (contract_id, quantity_for_sale, latitude, longitude, status)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [contract_id, quantity_for_sale, latitude, longitude, status || 'available']
    );

    res.status(201).json({ message: 'Trader product listed successfully', data: result.rows[0] });
  } catch (error) {
    console.error('Error creating trader product:', error);
    res.status(500).json({ error: error.message || 'Server error' });
  }
};

/**
 * Get all product listings for a specific trader.
 */
const getTraderProducts = async (req, res) => {
  try {
    const { trader_id } = req.params;

    const result = await db.query(
      `SELECT 
        tp.*,
        c.middleman_id,
        c.trader_selling_price,
        p.name AS product_name,
        p.category,
        p.expiry_date,
        p.image_url
       FROM public.trader_product tp
       INNER JOIN public.contracts c ON tp.contract_id = c.id
       LEFT JOIN public.product p ON c.product_id = p.id
       WHERE c.middleman_id = $1
       ORDER BY tp.created_at DESC`,
      [trader_id]
    );

    const flattenedData = result.rows.map((item) => ({
      id: item.id,
      contract_id: item.contract_id,
      quantity_for_sale: item.quantity_for_sale,
      latitude: item.latitude,
      longitude: item.longitude,
      status: item.status,
      created_at: item.created_at,
      product_name: item.product_name,
      trader_selling_price: item.trader_selling_price,
      category: item.category,
      image_url: item.image_url,
      expiry_date: item.expiry_date,
    }));

    res.status(200).json({ data: flattenedData });
  } catch (error) {
    console.error('Error fetching trader products:', error);
    res.status(500).json({ error: error.message || 'Server error' });
  }
};

/**
 * Get a single trader product listing by ID.
 */
const getTraderProductById = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await db.query(
      `SELECT 
        tp.*,
        c.middleman_id,
        c.trader_selling_price,
        p.name AS product_name,
        p.category,
        p.image_url
       FROM public.trader_product tp
       INNER JOIN public.contracts c ON tp.contract_id = c.id
       LEFT JOIN public.product p ON c.product_id = p.id
       WHERE tp.id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Product listing not found' });
    }

    res.status(200).json({ data: result.rows[0] });
  } catch (error) {
    console.error('Error fetching trader product detail:', error);
    res.status(500).json({ error: error.message || 'Server error' });
  }
};

/**
 * Update the status of a trader product (e.g., 'sold', 'available', 'hidden').
 */
const updateTraderProductStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    const result = await db.query(
      `UPDATE public.trader_product SET status = $1 WHERE id = $2 RETURNING *`,
      [status, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Product listing not found' });
    }

    res.status(200).json({ message: 'Product status updated', data: result.rows[0] });
  } catch (error) {
    console.error('Error updating trader product status:', error);
    res.status(500).json({ error: error.message || 'Server error' });
  }
};

module.exports = {
  createTraderProduct,
  getTraderProducts,
  getTraderProductById,
  updateTraderProductStatus,
};
