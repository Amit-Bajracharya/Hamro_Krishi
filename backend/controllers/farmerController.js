const db = require('../db');

/**
 * GET /api/farmers
 * List all farmers with optional pagination and search
 */
exports.getAllFarmers = async (req, res) => {
  const { page = 1, limit = 10, search = '' } = req.query;
  const offset = (parseInt(page) - 1) * parseInt(limit);

  try {
    let baseQuery = `FROM public.farmers`;
    const values = [];

    if (search) {
      baseQuery += ` WHERE name ILIKE $1 OR email ILIKE $1 OR phone ILIKE $1`;
      values.push(`%${search}%`);
    }

    const countResult = await db.query(
      `SELECT COUNT(*) ${baseQuery}`,
      values
    );

    const dataValues = [...values, parseInt(limit), offset];
    const limitIdx = values.length + 1;
    const offsetIdx = values.length + 2;

    const result = await db.query(
      `SELECT * ${baseQuery} ORDER BY created_at DESC LIMIT $${limitIdx} OFFSET $${offsetIdx}`,
      dataValues
    );

    res.status(200).json({
      success: true,
      meta: {
        total: parseInt(countResult.rows[0].count),
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(parseInt(countResult.rows[0].count) / parseInt(limit)),
      },
      farmers: result.rows,
    });
  } catch (error) {
    console.error('Get All Farmers Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch farmers' });
  }
};

/**
 * GET /api/farmers/:id
 * Get a single farmer by ID
 */
exports.getFarmerById = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query(
      'SELECT * FROM public.farmers WHERE id = $1',
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found' });
    }
    res.status(200).json({ success: true, farmer: result.rows[0] });
  } catch (error) {
    console.error('Get Farmer By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch farmer' });
  }
};

/**
 * GET /api/farmers/nearby
 * Find farmers within a radius (km) of a lat/lng point
 */
exports.getNearbyFarmers = async (req, res) => {
  const { lat, lng, radius = 10 } = req.query;

  if (!lat || !lng) {
    return res.status(400).json({ success: false, error: 'lat and lng query parameters are required' });
  }

  const latNum = parseFloat(lat);
  const lngNum = parseFloat(lng);
  const radiusNum = parseFloat(radius);

  if (isNaN(latNum) || isNaN(lngNum) || isNaN(radiusNum)) {
    return res.status(400).json({ success: false, error: 'lat, lng, and radius must be valid numbers' });
  }

  try {
    // Bounding box approximation first for efficiency
    const latDelta = radiusNum / 111.0;
    const lngDelta = radiusNum / (111.0 * Math.cos((latNum * Math.PI) / 180));

    const result = await db.query(
      `SELECT * FROM public.farmers
       WHERE latitude  BETWEEN $1 AND $2
         AND longitude BETWEEN $3 AND $4`,
      [latNum - latDelta, latNum + latDelta, lngNum - lngDelta, lngNum + lngDelta]
    );

    // Precise Haversine filter
    const toRad = (deg) => (deg * Math.PI) / 180;
    const haversine = (lat1, lon1, lat2, lon2) => {
      const R = 6371;
      const dLat = toRad(lat2 - lat1);
      const dLon = toRad(lon2 - lon1);
      const a =
        Math.sin(dLat / 2) ** 2 +
        Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) ** 2;
      return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    };

    const nearby = result.rows
      .map((f) => ({
        ...f,
        distance_km: parseFloat(haversine(latNum, lngNum, f.latitude, f.longitude).toFixed(2)),
      }))
      .filter((f) => f.distance_km <= radiusNum)
      .sort((a, b) => a.distance_km - b.distance_km);

    res.status(200).json({
      success: true,
      meta: { count: nearby.length, radius_km: radiusNum },
      farmers: nearby,
    });
  } catch (error) {
    console.error('Get Nearby Farmers Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch nearby farmers' });
  }
};

/**
 * POST /api/farmers
 * Create a new farmer (id must match an existing auth.users UUID)
 */
exports.createFarmer = async (req, res) => {
  const { id, name, email, phone, latitude, longitude } = req.body;

  if (!id || !name || !email || !phone || latitude === undefined || longitude === undefined) {
    return res.status(400).json({
      success: false,
      error: 'id, name, email, phone, latitude, and longitude are all required',
    });
  }

  try {
    const result = await db.query(
      `INSERT INTO public.farmers (id, name, email, phone, latitude, longitude)
       VALUES ($1, $2, $3, $4, $5, $6)
       RETURNING *`,
      [id, name, email, phone, latitude, longitude]
    );

    res.status(201).json({
      success: true,
      message: 'Farmer created successfully',
      farmer: result.rows[0],
    });
  } catch (error) {
    console.error('Create Farmer Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'A farmer with this email already exists' });
    }
    if (error.code === '23503') {
      return res.status(400).json({ success: false, error: 'Invalid user ID — must exist in auth.users' });
    }
    res.status(500).json({ success: false, error: 'Failed to create farmer' });
  }
};

/**
 * PATCH /api/farmers/:id
 * Partially update a farmer
 */
exports.updateFarmer = async (req, res) => {
  const { id } = req.params;
  const allowedFields = ['name', 'email', 'phone', 'latitude', 'longitude'];

  const updates = [];
  const values = [];
  let idx = 1;

  for (const field of allowedFields) {
    if (req.body[field] !== undefined) {
      updates.push(`${field} = $${idx++}`);
      values.push(req.body[field]);
    }
  }

  if (updates.length === 0) {
    return res.status(400).json({ success: false, error: 'No valid fields provided for update' });
  }

  values.push(id);

  try {
    const result = await db.query(
      `UPDATE public.farmers SET ${updates.join(', ')} WHERE id = $${idx} RETURNING *`,
      values
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found' });
    }

    res.status(200).json({
      success: true,
      message: 'Farmer updated successfully',
      farmer: result.rows[0],
    });
  } catch (error) {
    console.error('Update Farmer Error:', error);
    if (error.code === '23505') {
      return res.status(409).json({ success: false, error: 'Email already in use by another farmer' });
    }
    res.status(500).json({ success: false, error: 'Failed to update farmer' });
  }
};

/**
 * DELETE /api/farmers/:id
 * Delete a farmer
 */
exports.deleteFarmer = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query(
      'DELETE FROM public.farmers WHERE id = $1 RETURNING *',
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Farmer not found' });
    }
    res.status(200).json({ success: true, message: 'Farmer deleted successfully' });
  } catch (error) {
    console.error('Delete Farmer Error:', error);
    res.status(500).json({ success: false, error: 'Failed to delete farmer' });
  }
};