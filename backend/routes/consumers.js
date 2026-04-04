const express = require('express');
const router = express.Router();
const db = require('../db');
const supabaseAdmin = require('../supabaseAdmin');

// @route   POST /api/consumers
// @desc    Add a new consumer (Creates Supabase User + PostgreSQL Profile)
router.post('/', async (req, res) => {
  const { name, email, password, phone, latitude, longitude } = req.body;

  if (!name || !email || !password || !phone || latitude === undefined || longitude === undefined) {
    return res.status(400).json({ success: false, error: 'Please provide all required fields' });
  }

  try {
    // 1. Create User in Supabase Auth (Admin)
    const { data: authData, error: authError } = await supabaseAdmin.auth.admin.createUser({
      email: email,
      password: password,
      email_confirm: true
    });

    if (authError) {
      console.error('Supabase Auth Error (Consumer):', authError.message);
      return res.status(400).json({ success: false, error: authError.message });
    }

    const userId = authData?.user?.id;

    if (!userId) {
      throw new Error('Could not generate User ID from Supabase.');
    }

    // 2. Create Consumer Profile in PostgreSQL (public.customers)
    const query = `
      INSERT INTO public.customers (id, name, email, phone, latitude, longitude)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *;
    `;
    const values = [userId, name, email, phone, latitude, longitude];
    const result = await db.query(query, values);

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Error adding consumer:', error);
    if (error.code === '23505') {
      return res.status(400).json({ success: false, error: 'A consumer with this email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating consumer registration.' });
  }
});

module.exports = router;
