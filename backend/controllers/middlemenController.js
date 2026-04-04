const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../db');

// Register Endpoint for Middlemen
exports.register = async (req, res) => {
  const { email, password, name, phone, latitude, longitude, business_name, operating_regions } = req.body;

  try {
    // 1. Check if user already exists
    const existingUser = await db.query('SELECT id FROM public.middlemen WHERE email = $1', [email]);
    if (existingUser.rows.length > 0) {
      return res.status(400).json({ success: false, error: 'Middleman with this email already exists' });
    }

    // 2. Hash password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // 3. Begin Transaction
    await db.query('BEGIN');

    // Insert into auth.users 
    const userResult = await db.query(
      `INSERT INTO auth.users 
        (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, created_at, updated_at) 
       VALUES 
        ('00000000-0000-0000-0000-000000000000', gen_random_uuid(), 'authenticated', 'authenticated', $1, $2, now(), now(), now()) 
       RETURNING id`,
      [email, hashedPassword]
    );

    const userId = userResult.rows[0].id;

    // 4. Insert into public.middlemen profile
    const middlemanResult = await db.query(
      `INSERT INTO public.middlemen 
        (id, name, email, phone, latitude, longitude, business_name, operating_regions) 
       VALUES 
        ($1, $2, $3, $4, $5, $6, $7, $8) 
       RETURNING *`,
      [userId, name, email, phone, latitude, longitude, business_name, operating_regions]
    );

    // 5. Commit Transaction
    await db.query('COMMIT');

    // 6. Generate JWT token
    const token = jwt.sign(
      { id: userId, email, role: 'middleman' },
      process.env.JWT_SECRET || 'supersecret_secret_key_hamro_krishi_123!',
      { expiresIn: '7d' }
    );

    res.status(201).json({
      success: true,
      message: 'Middleman registration successful',
      token,
      user: middlemanResult.rows[0],
    });
  } catch (error) {
    await db.query('ROLLBACK');
    console.error('Middleman Registration Error:', error);
    res.status(500).json({ success: false, error: 'Failed to register middleman' });
  }
};

// Login Endpoint for Middlemen
exports.login = async (req, res) => {
  const { email, password } = req.body;

  try {
    // 1. Fetch user from auth.users
    const authUserResult = await db.query('SELECT id, encrypted_password FROM auth.users WHERE email = $1', [email]);
    
    if (authUserResult.rows.length === 0) {
      return res.status(401).json({ success: false, error: 'Invalid email or password' });
    }

    const authUser = authUserResult.rows[0];

    // 2. Validate Password
    const isMatch = await bcrypt.compare(password, authUser.encrypted_password);
    if (!isMatch) {
      return res.status(401).json({ success: false, error: 'Invalid email or password' });
    }

    // 3. Fetch public profile from middlemen
    const profileResult = await db.query('SELECT * FROM public.middlemen WHERE id = $1', [authUser.id]);
    
    // Enforce that the user logging in MUST be a middleman
    if (profileResult.rows.length === 0) {
      return res.status(403).json({ success: false, error: 'User is not registered as a middleman' });
    }

    // 4. Generate JWT token
    const token = jwt.sign(
      { id: authUser.id, email, role: 'middleman' },
      process.env.JWT_SECRET || 'supersecret_secret_key_hamro_krishi_123!',
      { expiresIn: '7d' }
    );

    res.status(200).json({
      success: true,
      message: 'Middleman login successful',
      token,
      user: profileResult.rows[0],
    });
  } catch (error) {
    console.error('Middleman Login Error:', error);
    res.status(500).json({ success: false, error: 'Failed to log in middleman' });
  }
};
