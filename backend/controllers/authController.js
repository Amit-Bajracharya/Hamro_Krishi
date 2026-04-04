const db = require('../db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.login = async (req, res) => {
  const { identity, password } = req.body; // identity can be email

  if (!identity || !password) {
    return res.status(400).json({ success: false, error: 'Please provide email and password' });
  }

  try {
    // 1. Fetch user from auth.users (Supabase internal table)
    // We check email first.
    const authUserResult = await db.query(
      'SELECT id, email, encrypted_password FROM auth.users WHERE email = $1',
      [identity]
    );

    if (authUserResult.rows.length === 0) {
      return res.status(401).json({ success: false, error: 'Invalid email or password' });
    }

    const authUser = authUserResult.rows[0];

    // 2. Validate Password
    const isMatch = await bcrypt.compare(password, authUser.encrypted_password);
    if (!isMatch) {
      return res.status(401).json({ success: false, error: 'Invalid email or password' });
    }

    // 3. Identify Role by probing the three profile tables
    let role = null;
    let userProfile = null;

    // Check Farmer
    const farmerResult = await db.query('SELECT * FROM public.farmers WHERE id = $1', [authUser.id]);
    if (farmerResult.rows.length > 0) {
      role = 'farmer';
      userProfile = farmerResult.rows[0];
    } else {
      // Check Middleman (Trader)
      const middlemanResult = await db.query('SELECT * FROM public.middlemen WHERE id = $1', [authUser.id]);
      if (middlemanResult.rows.length > 0) {
        role = 'trader';
        userProfile = middlemanResult.rows[0];
      } else {
        // Check Customer (Consumer)
        const customerResult = await db.query('SELECT * FROM public.customers WHERE id = $1', [authUser.id]);
        if (customerResult.rows.length > 0) {
          role = 'consumer';
          userProfile = customerResult.rows[0];
        }
      }
    }

    if (!role) {
      return res.status(403).json({ success: false, error: 'User profile not found for any role' });
    }

    // 4. Generate JWT token
    const token = jwt.sign(
      { id: authUser.id, email: authUser.email, role: role },
      process.env.JWT_SECRET || 'supersecret_secret_key_hamro_krishi_123!',
      { expiresIn: '7d' }
    );

    // 5. Success Response
    res.status(200).json({
      success: true,
      message: 'Login successful',
      token,
      role: role,
      id: userProfile.id,
      name: userProfile.name,
      email: userProfile.email,
      phone: userProfile.phone || userProfile.phone_number
    });

  } catch (error) {
    console.error('Unified Login Error:', error);
    res.status(500).json({ success: false, error: 'Server error during login' });
  }
};
