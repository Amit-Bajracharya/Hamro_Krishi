const supabase = require('../config/supabase');

/**
 * GET /api/customers
 * List all customers with optional pagination and search
 */
const getAllCustomers = async (req, res, next) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const search = req.query.search || '';
    const offset = (page - 1) * limit;

    let query = supabase
      .from('customers')
      .select('*', { count: 'exact' })
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (search) {
      query = query.or(
        `name.ilike.%${search}%,email.ilike.%${search}%,phone.ilike.%${search}%`
      );
    }

    const { data, error, count } = await query;

    if (error) throw error;

    res.json({
      data,
      meta: {
        total: count,
        page,
        limit,
        totalPages: Math.ceil(count / limit),
      },
    });
  } catch (err) {
    next(err);
  }
};

/**
 * GET /api/customers/:id
 * Get a single customer by ID
 */
const getCustomerById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const { data, error } = await supabase
      .from('customers')
      .select('*')
      .eq('id', id)
      .single();

    if (error) {
      if (error.code === 'PGRST116') {
        return res.status(404).json({ error: 'Customer not found' });
      }
      throw error;
    }

    res.json({ data });
  } catch (err) {
    next(err);
  }
};

/**
 * POST /api/customers
 * Create a new customer
 */
const createCustomer = async (req, res, next) => {
  try {
    const { name, email, phone, latitude, longitude } = req.body;

    // If no ID is provided, the caller must pass an id that matches auth.users
    // because of the FK constraint. Allow optional id from body.
    const id = req.body.id; // must be an existing auth.users UUID

    const payload = { name, email, phone, latitude, longitude };
    if (id) payload.id = id;

    const { data, error } = await supabase
      .from('customers')
      .insert(payload)
      .select()
      .single();

    if (error) throw error;

    res.status(201).json({ data });
  } catch (err) {
    next(err);
  }
};

/**
 * PUT /api/customers/:id
 * Replace a customer record (full update)
 */
const replaceCustomer = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { name, email, phone, latitude, longitude } = req.body;

    const { data, error } = await supabase
      .from('customers')
      .update({ name, email, phone, latitude, longitude })
      .eq('id', id)
      .select()
      .single();

    if (error) {
      if (error.code === 'PGRST116') {
        return res.status(404).json({ error: 'Customer not found' });
      }
      throw error;
    }

    res.json({ data });
  } catch (err) {
    next(err);
  }
};

/**
 * PATCH /api/customers/:id
 * Partially update a customer
 */
const updateCustomer = async (req, res, next) => {
  try {
    const { id } = req.params;
    const allowedFields = ['name', 'email', 'phone', 'latitude', 'longitude'];

    const updates = {};
    for (const field of allowedFields) {
      if (req.body[field] !== undefined) {
        updates[field] = req.body[field];
      }
    }

    if (Object.keys(updates).length === 0) {
      return res.status(400).json({ error: 'No valid fields provided for update' });
    }

    const { data, error } = await supabase
      .from('customers')
      .update(updates)
      .eq('id', id)
      .select()
      .single();

    if (error) {
      if (error.code === 'PGRST116') {
        return res.status(404).json({ error: 'Customer not found' });
      }
      throw error;
    }

    res.json({ data });
  } catch (err) {
    next(err);
  }
};

/**
 * DELETE /api/customers/:id
 * Delete a customer
 */
const deleteCustomer = async (req, res, next) => {
  try {
    const { id } = req.params;

    const { data, error } = await supabase
      .from('customers')
      .delete()
      .eq('id', id)
      .select()
      .single();

    if (error) {
      if (error.code === 'PGRST116') {
        return res.status(404).json({ error: 'Customer not found' });
      }
      throw error;
    }

    res.json({ message: 'Customer deleted successfully', data });
  } catch (err) {
    next(err);
  }
};

/**
 * GET /api/customers/nearby
 * Find customers within a radius (km) of a lat/lng point
 */
const getNearbyCustomers = async (req, res, next) => {
  try {
    const { lat, lng, radius = 10 } = req.query;

    if (!lat || !lng) {
      return res.status(400).json({ error: 'lat and lng query parameters are required' });
    }

    const latNum = parseFloat(lat);
    const lngNum = parseFloat(lng);
    const radiusNum = parseFloat(radius);

    if (isNaN(latNum) || isNaN(lngNum) || isNaN(radiusNum)) {
      return res.status(400).json({ error: 'lat, lng, and radius must be valid numbers' });
    }

    // Haversine approximation using bounding box first, then filter
    const latDelta = radiusNum / 111.0;
    const lngDelta = radiusNum / (111.0 * Math.cos((latNum * Math.PI) / 180));

    const { data, error } = await supabase
      .from('customers')
      .select('*')
      .gte('latitude', latNum - latDelta)
      .lte('latitude', latNum + latDelta)
      .gte('longitude', lngNum - lngDelta)
      .lte('longitude', lngNum + lngDelta);

    if (error) throw error;

    // Precise haversine filter
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

    const nearby = data
      .map((c) => ({
        ...c,
        distance_km: parseFloat(
          haversine(latNum, lngNum, c.latitude, c.longitude).toFixed(2)
        ),
      }))
      .filter((c) => c.distance_km <= radiusNum)
      .sort((a, b) => a.distance_km - b.distance_km);

    res.json({ data: nearby, meta: { count: nearby.length, radius_km: radiusNum } });
  } catch (err) {
    next(err);
  }
};

module.exports = {
  getAllCustomers,
  getCustomerById,
  createCustomer,
  replaceCustomer,
  updateCustomer,
  deleteCustomer,
  getNearbyCustomers,
};