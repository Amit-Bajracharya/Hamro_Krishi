const express = require('express');
const router = express.Router();
const db = require('../db');
const supabaseAdmin = require('../supabaseAdmin');

// @route   POST /api/traders
// @desc    Add a new trader (Creates Supabase User + PostgreSQL Profile)
router.post('/', async (req, res) => {
  const { name, email, password, phone, latitude, longitude, business_name, operating_regions } = req.body;

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
      console.error('Supabase Auth Error (Trader):', authError.message);
      return res.status(400).json({ success: false, error: authError.message });
    }

    const userId = authData?.user?.id;

    if (!userId) {
      throw new Error('Could not generate User ID from Supabase.');
    }

    // 2. Format operating_regions into an array (PostgreSQL expectation)
    const regionsArray = operating_regions 
      ? operating_regions.split(',').map(r => r.trim()).filter(r => r.length > 0)
      : [];

    // 3. Create Trader Profile in PostgreSQL (public.middlemen)
    const query = `
      INSERT INTO public.middlemen (id, name, email, phone, latitude, longitude, business_name, operating_regions)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING *;
    `;
    const values = [userId, name, email, phone, latitude, longitude, business_name, regionsArray];
    const result = await db.query(query, values);

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Error adding trader:', error);
    if (error.code === '23505') {
      return res.status(400).json({ success: false, error: 'A trader with this email already exists.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating trader registration.' });
  }
});

module.exports = router;
