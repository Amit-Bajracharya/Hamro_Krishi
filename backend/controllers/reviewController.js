const db = require('../db');

const VALID_REVIEWER_ROLES = ['farmer', 'middleman', 'customer'];
const VALID_TARGET_ROLES   = ['farmer', 'middleman'];

// POST /api/reviews
exports.createReview = async (req, res) => {
  const { reviewer_id, reviewer_role, target_id, target_role, order_id, rating, comment } = req.body;

  if (!reviewer_id || !reviewer_role || !target_id || !target_role || !rating) {
    return res.status(400).json({ success: false, error: 'reviewer_id, reviewer_role, target_id, target_role, rating are required' });
  }

  if (!VALID_REVIEWER_ROLES.includes(reviewer_role)) {
    return res.status(400).json({ success: false, error: 'reviewer_role must be farmer, middleman, or customer' });
  }

  if (!VALID_TARGET_ROLES.includes(target_role)) {
    return res.status(400).json({ success: false, error: 'target_role must be farmer or middleman' });
  }

  if (rating < 1 || rating > 5) {
    return res.status(400).json({ success: false, error: 'rating must be between 1 and 5' });
  }

  try {
    const result = await db.query(
      `INSERT INTO public.reviews (reviewer_id, reviewer_role, target_id, target_role, order_id, rating, comment)
       VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *`,
      [reviewer_id, reviewer_role, target_id, target_role, order_id || null, rating, comment || null]
    );
    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Review Error:', error);
    if (error.code === '23503') {
      return res.status(404).json({ success: false, error: 'Referenced order does not exist.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating review.' });
  }
};

// GET /api/reviews
exports.getAllReviews = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.reviews ORDER BY created_at DESC');
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get All Reviews Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch reviews.' });
  }
};

// GET /api/reviews/:id
exports.getReviewById = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM public.reviews WHERE id = $1', [req.params.id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Review not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Review By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch review.' });
  }
};

// GET /api/reviews/target/:target_id — all reviews for a farmer or middleman
exports.getReviewsByTarget = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT * FROM public.reviews WHERE target_id = $1 ORDER BY created_at DESC`,
      [req.params.target_id]
    );

    // compute average rating
    const avg = result.rows.length
      ? (result.rows.reduce((sum, r) => sum + r.rating, 0) / result.rows.length).toFixed(2)
      : null;

    res.json({ success: true, count: result.rowCount, average_rating: avg ? parseFloat(avg) : null, data: result.rows });
  } catch (error) {
    console.error('Get Reviews By Target Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch reviews.' });
  }
};

// GET /api/reviews/reviewer/:reviewer_id — all reviews written by a user
exports.getReviewsByReviewer = async (req, res) => {
  try {
    const result = await db.query(
      `SELECT * FROM public.reviews WHERE reviewer_id = $1 ORDER BY created_at DESC`,
      [req.params.reviewer_id]
    );
    res.json({ success: true, count: result.rowCount, data: result.rows });
  } catch (error) {
    console.error('Get Reviews By Reviewer Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch reviews.' });
  }
};

// DELETE /api/reviews/:id
exports.deleteReview = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.reviews WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Review not found.' });
    }
    res.json({ success: true, message: 'Review deleted successfully.' });
  } catch (error) {
    console.error('Delete Review Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting review.' });
  }
};