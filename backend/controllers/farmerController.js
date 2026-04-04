const db = require('../db');
const { randomUUID } = require('crypto');

exports.createFarmer = async (req, res) => {
  const { name, email, phone, latitude, longitude } = req.body;

  if (!name || !email || !phone || latitude === undefined || longitude === undefined) {
    return res.status(400).json({ success: false, error: 'name, email, phone, latitude, longitude are required' });
  }

  try {
    const id = randomUUID();

    await db.query(
      `INSERT INTO auth.users (id, email, created_at, updated_at, role, aud)
       VALUES ($1, $2, now(), now(), 'authenticated', 'authenticated')
       ON CONFLICT (id) DO NOTHING`,
      [id, email]
    );

    const result = await db.query(
      `INSERT INTO public.farmers (id, name, email, phone, latitude, longitude)
       VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [id, name, email, phone, latitude, longitude]
    );

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Farmer Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'A farmer with this email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating farmer.' });
  }
};

exports.getAllFarmers = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.farmers ORDER BY created_at DESC');
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get All Farmers Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch farmers.' });
  }
};

exports.getFarmerById = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.farmers WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Farmer By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch farmer.' });
  }
};

exports.updateFarmer = async (req, res) => {
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
      `UPDATE public.farmers SET ${updates.join(', ')} WHERE id = $${i} RETURNING *`,
      values
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Update Farmer Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'Email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error updating farmer.' });
  }
};

exports.deleteFarmer = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.farmers WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found.' });
    }
    res.json({ success: true, message: 'Farmer deleted successfully.' });
  } catch (error) {
    console.error('Delete Farmer Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting farmer.' });
  }
};