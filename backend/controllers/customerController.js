const db = require('../db');
const { randomUUID } = require('crypto');
const bcrypt = require('bcrypt');

const toRad = (d) => (d * Math.PI) / 180;
const haversine = (lat1, lon1, lat2, lon2) => {
  const R = 6371;
  const dLat = toRad(lat2 - lat1);
  const dLon = toRad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) ** 2;
  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
};

// GET /api/customers/marketplace — Price Transparency Feed
exports.getConsumerMarketplace = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT 
        c.id AS contract_id,
        c.product_id,
        c.farmer_id,
        c.middleman_id,
        c.quantity,
        c.farmer_selling_price,
        c.trader_selling_price,
        c.status,
        c.created_at,
        p.name AS product_name,
        p.category,
        p.image_url,
        p.expiry_date,
        f.name AS farmer_name,
        f.latitude AS farmer_latitude,
        f.longitude AS farmer_longitude,
        m.name AS trader_name,
        m.business_name
       FROM public.contracts c
       LEFT JOIN public.product p ON c.product_id = p.id
       LEFT JOIN public.farmers f ON c.farmer_id = f.id
       LEFT JOIN public.middlemen m ON c.middleman_id = m.id
       WHERE c.status = 'active'
       ORDER BY c.created_at DESC`
    );

    const items = result.rows.map((row) => ({
      contract_id: row.contract_id,
      product_id: row.product_id,
      farmer_id: row.farmer_id,
      middleman_id: row.middleman_id,
      product_name: row.product_name || 'Unknown Product',
      category: row.category || 'other',
      quantity: parseFloat(row.quantity) || 0,
      farmer_selling_price: parseFloat(row.farmer_selling_price) || 0,
      trader_selling_price: parseFloat(row.trader_selling_price) || 0,
      status: row.status,
      farmer_name: row.farmer_name || 'Unknown Farmer',
      trader_name: row.trader_name || row.business_name || 'Unknown Trader',
      image_url: row.image_url,
      expiry_date: row.expiry_date,
      farmer_latitude: row.farmer_latitude,
      farmer_longitude: row.farmer_longitude,
      created_at: row.created_at,
    }));

    res.status(200).json({ success: true, count: items.length, data: items });
  } catch (error) {
    console.error('Get Consumer Marketplace Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch marketplace data.' });
  }
};

// POST /api/consumers
exports.createConsumer = async (req, res) => {
  const { name, email, password, phone, latitude, longitude } = req.body;

  if (!name || !email || !password || !phone || latitude === undefined || longitude === undefined) {
    return res.status(400).json({ success: false, error: 'name, email, password, phone, latitude, longitude are required' });
  }

  try {
    const id = randomUUID();
    const hashedPassword = await bcrypt.hash(password, 10);

    await db.query(
      `INSERT INTO auth.users (id, email, encrypted_password, created_at, updated_at, role, aud)
       VALUES ($1, $2, $3, now(), now(), 'authenticated', 'authenticated')
       ON CONFLICT (id) DO NOTHING`,
      [id, email, hashedPassword]
    );

    const result = await db.query(
      `INSERT INTO public.customers (id, name, email, phone, latitude, longitude)
       VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [id, name, email, phone, latitude, longitude]
    );

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Consumer Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'A consumer with this email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating consumer.' });
  }
};

// GET /api/consumers
exports.getAllConsumers = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.customers ORDER BY created_at DESC');
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get All Consumers Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch consumers.' });
  }
};

// GET /api/consumers/nearby?lat=&lng=&radius=
exports.getNearbyConsumers = async (req, res) => {
  const { lat, lng, radius = 10 } = req.query;

  if (!lat || !lng) {
    return res.status(400).json({ success: false, error: 'lat and lng are required' });
  }

  const latNum = parseFloat(lat);
  const lngNum = parseFloat(lng);
  const radiusNum = parseFloat(radius);

  if (isNaN(latNum) || isNaN(lngNum) || isNaN(radiusNum)) {
    return res.status(400).json({ success: false, error: 'lat, lng, radius must be valid numbers' });
  }

  try {
    const latDelta = radiusNum / 111.0;
    const lngDelta = radiusNum / (111.0 * Math.cos(toRad(latNum)));

    const result = await db.query(
      `SELECT * FROM public.customers
       WHERE latitude  BETWEEN $1 AND $2
         AND longitude BETWEEN $3 AND $4`,
      [latNum - latDelta, latNum + latDelta, lngNum - lngDelta, lngNum + lngDelta]
    );

    const nearby = result.rows
      .map((c) => ({ ...c, distance_km: parseFloat(haversine(latNum, lngNum, c.latitude, c.longitude).toFixed(2)) }))
      .filter((c) => c.distance_km <= radiusNum)
      .sort((a, b) => a.distance_km - b.distance_km);

    res.json({ success: true, count: nearby.length, radius_km: radiusNum, data: nearby });
  } catch (error) {
    console.error('Get Nearby Consumers Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch nearby consumers.' });
  }
};

// GET /api/consumers/:id
exports.getConsumerById = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.customers WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Consumer not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Consumer By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch consumer.' });
  }
};

// PUT /api/consumers/:id
exports.updateConsumer = async (req, res) => {
  const { id } = req.params;
  const allowedFields = ['name', 'email', 'phone', 'latitude', 'longitude'];
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
      `UPDATE public.customers SET ${updates.join(', ')} WHERE id = $${i} RETURNING *`,
      values
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Consumer not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Update Consumer Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'Email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error updating consumer.' });
  }
};

// DELETE /api/consumers/:id
exports.deleteConsumer = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.customers WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Consumer not found.' });
    }
    res.json({ success: true, message: 'Consumer deleted successfully.' });
  } catch (error) {
    console.error('Delete Consumer Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting consumer.' });
  }
};