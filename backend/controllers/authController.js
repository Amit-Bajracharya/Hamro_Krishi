const db = require('../db');
const bcrypt = require('bcrypt');

exports.login = async (req, res) => {
  const { identity, password } = req.body; // identity can be email

  if (!identity || !password) {
    return res.status(400).json({ success: false, error: 'Please provide email and password' });
  }

  try {
    let userResult = null;
    let userTable = '';
    let userRole = '';

    // Check farmers table first
    userResult = await db.query('SELECT * FROM public.farmers WHERE email = $1', [identity]);
    if (userResult.rows.length > 0) {
      userTable = 'farmers';
      userRole = 'farmer';
    } else {
      // Check customers table
      userResult = await db.query('SELECT * FROM public.customers WHERE email = $1', [identity]);
      if (userResult.rows.length > 0) {
        userTable = 'customers';
        userRole = 'customer';
      } else {
        // Check middlemen table
        userResult = await db.query('SELECT * FROM public.middlemen WHERE email = $1', [identity]);
        if (userResult.rows.length > 0) {
          userTable = 'middlemen';
          userRole = 'middleman';
        }
      }
    }

    if (userResult.rows.length === 0) {
      return res.status(401).json({ success: false, error: 'Invalid email or password' });
    }

    const user = userResult.rows[0];

    // Check if user has password_hash, if not accept any password for testing
    if (!user.password_hash) {
      console.log(`⚠️  No password field found in ${userTable} - accepting any password for testing`);
    } else {
      // Validate Password
      const isMatch = await bcrypt.compare(password, user.password_hash);
      if (!isMatch) {
        return res.status(401).json({ success: false, error: 'Invalid email or password' });
      }
    }

    // Log the successful login with role information from the table
    console.log(`🔐 ${userRole.toUpperCase()} Login Successful:`, {
      id: user.id,
      email: user.email,
      name: user.name,
      role: userRole,
      table: userTable,
      timestamp: new Date().toISOString()
    });

    // Success Response - No JWT token (add empty token for mobile compatibility)
    console.log(`🔍 DEBUG: Returning user with role: ${userRole}`);
    res.status(200).json({
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone || user.phone_number,
      role: userRole,
      latitude: user.latitude,
      longitude: user.longitude,
      token: '', // Empty token for mobile app compatibility
      ...(userRole === 'middleman' && { 
        business_name: user.business_name,
        operating_regions: user.operating_regions 
      })
    });

  } catch (error) {
    console.error('Login Error:', error);
    res.status(500).json({ success: false, error: 'Server error during login' });
  }
};

// Get user profile based on session (no JWT)
exports.getProfile = async (req, res) => {
  try {
    // This would typically use session or token, but since we removed JWT,
    // this endpoint might not be needed or would need a different auth mechanism
    res.status(501).json({ 
      success: false, 
      error: 'Profile endpoint not implemented without JWT authentication' 
    });
  } catch (error) {
    console.error('Get Profile Error:', error);
    res.status(500).json({ success: false, error: 'Server error getting profile' });
  }
};