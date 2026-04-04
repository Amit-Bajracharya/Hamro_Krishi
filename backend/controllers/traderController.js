const db = require('../db');
const { randomUUID } = require('crypto');
const bcrypt = require('bcrypt');

exports.createTrader = async (req, res) => {
  const { name, email, password, phone, latitude, longitude, business_name, operating_regions } = req.body;

  if (!name || !email || !password || !phone || latitude === undefined || longitude === undefined) {
    return res.status(400).json({ success: false, error: 'name, email, password, phone, latitude, longitude are required' });
  }

  const regionsArray = operating_regions
    ? operating_regions.split(',').map((r) => r.trim()).filter((r) => r.length > 0)
    : [];

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
      `INSERT INTO public.middlemen (id, name, email, phone, latitude, longitude, business_name, operating_regions)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [id, name, email, phone, latitude, longitude, business_name, regionsArray]
    );

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Trader Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'A trader with this email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating trader.' });
  }
};

exports.getAllTraders = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.middlemen ORDER BY created_at DESC');
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get All Traders Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch traders.' });
  }
};

exports.getTraderById = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.middlemen WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Trader not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Trader By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch trader.' });
  }
};

exports.updateTrader = async (req, res) => {
  const { id } = req.params;
  const allowedFields = ['name', 'email', 'phone', 'latitude', 'longitude', 'business_name', 'operating_regions'];
  const updates = [], values = [];
  let i = 1;

  for (const field of allowedFields) {
    if (req.body[field] !== undefined) {
      updates.push(`${field} = $${i++}`);
      values.push(
        field === 'operating_regions'
          ? req.body[field].split(',').map((r) => r.trim()).filter((r) => r.length > 0)
          : req.body[field]
      );
    }
  }

  if (updates.length === 0) {
    return res.status(400).json({ success: false, error: 'No valid fields provided for update.' });
  }

  values.push(id);
  try {
    const result = await db.query(
      `UPDATE public.middlemen SET ${updates.join(', ')} WHERE id = $${i} RETURNING *`,
      values
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Trader not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Update Trader Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'Email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error updating trader.' });
  }
};

exports.deleteTrader = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.middlemen WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Trader not found.' });
    }
    res.json({ success: true, message: 'Trader deleted successfully.' });
  } catch (error) {
    console.error('Delete Trader Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting trader.' });
  }
};