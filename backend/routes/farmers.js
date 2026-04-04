const express = require('express');
const router = express.Router();
const db = require('../db');

// @route   POST /api/farmers
// @desc    Add a new farmer
router.post('/', async (req, res) => {
  const { id, name, email, phone, latitude, longitude } = req.body;

  if (!id || !name || !email || !phone || latitude === undefined || longitude === undefined) {
    return res.status(400).json({ success: false, error: 'Please provide all required fields (id, name, email, phone, latitude, longitude)' });
  }

  try {
    const query = `
      INSERT INTO public.farmers (id, name, email, phone, latitude, longitude)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *;
    `;
    const values = [id, name, email, phone, latitude, longitude];
    const result = await db.query(query, values);

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Error adding farmer:', error);
    if (error.code === '23505') { // unique violation
      return res.status(400).json({ success: false, error: 'A farmer with this email already exists.' });
    }
    if (error.code === '23503') { // foreign key violation
      return res.status(400).json({ success: false, error: 'Invalid user ID. User must exist in auth.users.' });
    }
    res.status(500).json({ success: false, error: 'Server error adding farmer.' });
  }
});

// @route   PUT /api/farmers/:id
// @desc    Update a farmer
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { name, email, phone, latitude, longitude } = req.body;

  try {
    // Dynamically build the update query so we only update provided fields
    const updates = [];
    const values = [];
    let paramIndex = 1;

    if (name !== undefined) {
      updates.push(`name = $${paramIndex++}`);
      values.push(name);
    }
    if (email !== undefined) {
      updates.push(`email = $${paramIndex++}`);
      values.push(email);
    }
    if (phone !== undefined) {
      updates.push(`phone = $${paramIndex++}`);
      values.push(phone);
    }
    if (latitude !== undefined) {
      updates.push(`latitude = $${paramIndex++}`);
      values.push(latitude);
    }
    if (longitude !== undefined) {
      updates.push(`longitude = $${paramIndex++}`);
      values.push(longitude);
    }

    if (updates.length === 0) {
      return res.status(400).json({ success: false, error: 'No fields provided to update.' });
    }

    values.push(id);
    const query = `
      UPDATE public.farmers
      SET ${updates.join(', ')}
      WHERE id = $${paramIndex}
      RETURNING *;
    `;

    const result = await db.query(query, values);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found.' });
    }

    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Error updating farmer:', error);
    if (error.code === '23505') { // unique violation
      return res.status(400).json({ success: false, error: 'Email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error updating farmer.' });
  }
});

// @route   DELETE /api/farmers/:id
// @desc    Delete a farmer
router.delete('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const query = 'DELETE FROM public.farmers WHERE id = $1 RETURNING *;';
    const result = await db.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found.' });
    }

    res.json({ success: true, message: 'Farmer deleted successfully.' });
  } catch (error) {
    console.error('Error deleting farmer:', error);
    res.status(500).json({ success: false, error: 'Server error deleting farmer.' });
  }
});

module.exports = router;
