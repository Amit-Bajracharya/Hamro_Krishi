const db = require('../db');

/**
 * GET /api/reviews
 * List all reviews with optional filters and pagination
 */
exports.getAllReviews = async (req, res) => {
  const { target_id, reviewer_id, target_role, reviewer_role, order_id, page = 1, limit = 10 } = req.query;
  const offset = (parseInt(page) - 1) * parseInt(limit);

  try {
    const conditions = [];
    const values = [];
    let idx = 1;

    if (target_id)     { conditions.push(`target_id = $${idx++}`);     values.push(target_id); }
    if (reviewer_id)   { conditions.push(`reviewer_id = $${idx++}`);   values.push(reviewer_id); }
    if (target_role)   { conditions.push(`target_role = $${idx++}`);   values.push(target_role); }
    if (reviewer_role) { conditions.push(`reviewer_role = $${idx++}`); values.push(reviewer_role); }
    if (order_id)      { conditions.push(`order_id = $${idx++}`);      values.push(order_id); }

    const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';

    const countResult = await db.query(
      `SELECT COUNT(*) FROM public.reviews ${where}`,
      values
    );

    values.push(parseInt(limit), offset);
    const result = await db.query(
      `SELECT * FROM public.reviews ${where} ORDER BY created_at DESC LIMIT $${idx++} OFFSET $${idx++}`,
      values
    );

    res.status(200).json({
      success: true,
      meta: {
        total: parseInt(countResult.rows[0].count),
        page: parseInt(page),
        limit: parseInt(limit),
        totalPages: Math.ceil(parseInt(countResult.rows[0].count) / parseInt(limit)),
      },
      reviews: result.rows,
    });
  } catch (error) {
    console.error('Get All Reviews Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch reviews' });
  }
};

/**
 * GET /api/reviews/:id
 * Get a single review by ID
 */
exports.getReviewById = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query('SELECT * FROM public.reviews WHERE id = $1', [id]);
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Review not found' });
    }
    res.status(200).json({ success: true, review: result.rows[0] });
  } catch (error) {
    console.error('Get Review By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch review' });
  }
};

/**
 * GET /api/reviews/target/:target_id
 * Get all reviews for a specific target (farmer or middleman) with avg rating
 */
exports.getReviewsByTarget = async (req, res) => {
  const { target_id } = req.params;
  try {
    const result = await db.query(
      `SELECT * FROM public.reviews WHERE target_id = $1 ORDER BY created_at DESC`,
      [target_id]
    );
    const avgResult = await db.query(
      `SELECT ROUND(AVG(rating)::numeric, 2) as average_rating, COUNT(*) as total
       FROM public.reviews WHERE target_id = $1`,
      [target_id]
    );
    res.status(200).json({
      success: true,
      average_rating: parseFloat(avgResult.rows[0].average_rating) || 0,
      total: parseInt(avgResult.rows[0].total),
      reviews: result.rows,
    });
  } catch (error) {
    console.error('Get Reviews By Target Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch reviews for target' });
  }
};

/**
 * POST /api/reviews
 * Create a new review
 */
exports.createReview = async (req, res) => {
  const { reviewer_id, reviewer_role, target_id, target_role, order_id, rating, comment } = req.body;

  if (!reviewer_id || !reviewer_role || !target_id || !target_role || !rating) {
    return res.status(400).json({
      success: false,
      error: 'reviewer_id, reviewer_role, target_id, target_role, and rating are required',
    });
  }

  const validReviewerRoles = ['farmer', 'middleman', 'customer'];
  const validTargetRoles   = ['farmer', 'middleman'];

  if (!validReviewerRoles.includes(reviewer_role)) {
    return res.status(400).json({
      success: false,
      error: `reviewer_role must be one of: ${validReviewerRoles.join(', ')}`,
    });
  }
  if (!validTargetRoles.includes(target_role)) {
    return res.status(400).json({
      success: false,
      error: `target_role must be one of: ${validTargetRoles.join(', ')}`,
    });
  }
  if (rating < 1 || rating > 5) {
    return res.status(400).json({ success: false, error: 'Rating must be between 1 and 5' });
  }
  if (reviewer_id === target_id) {
    return res.status(400).json({ success: false, error: 'You cannot review yourself' });
  }

  try {
    const result = await db.query(
      `INSERT INTO public.reviews 
        (reviewer_id, reviewer_role, target_id, target_role, order_id, rating, comment)
       VALUES ($1, $2, $3, $4, $5, $6, $7)
       RETURNING *`,
      [reviewer_id, reviewer_role, target_id, target_role, order_id || null, rating, comment || null]
    );

    res.status(201).json({
      success: true,
      message: 'Review created successfully',
      review: result.rows[0],
    });
  } catch (error) {
    console.error('Create Review Error:', error);
    if (error.code === '23503') {
      return res.status(400).json({ success: false, error: 'Referenced order does not exist' });
    }
    if (error.code === '23514') {
      return res.status(400).json({ success: false, error: 'Constraint violation: check rating (1-5) and valid roles' });
    }
    res.status(500).json({ success: false, error: 'Failed to create review' });
  }
};

/**
 * PATCH /api/reviews/:id
 * Update rating or comment only (reviewer cannot change target/roles)
 */
exports.updateReview = async (req, res) => {
  const { id } = req.params;
  const { rating, comment } = req.body;

  if (rating === undefined && comment === undefined) {
    return res.status(400).json({ success: false, error: 'Provide rating and/or comment to update' });
  }
  if (rating !== undefined && (rating < 1 || rating > 5)) {
    return res.status(400).json({ success: false, error: 'Rating must be between 1 and 5' });
  }

  try {
    const check = await db.query('SELECT id FROM public.reviews WHERE id = $1', [id]);
    if (check.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Review not found' });
    }

    const result = await db.query(
      `UPDATE public.reviews
       SET
         rating  = COALESCE($1, rating),
         comment = COALESCE($2, comment)
       WHERE id = $3
       RETURNING *`,
      [rating ?? null, comment ?? null, id]
    );

    res.status(200).json({
      success: true,
      message: 'Review updated successfully',
      review: result.rows[0],
    });
  } catch (error) {
    console.error('Update Review Error:', error);
    if (error.code === '23514') {
      return res.status(400).json({ success: false, error: 'Rating must be between 1 and 5' });
    }
    res.status(500).json({ success: false, error: 'Failed to update review' });
  }
};

/**
 * DELETE /api/reviews/:id
 * Delete a review
 */
exports.deleteReview = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await db.query(
      'DELETE FROM public.reviews WHERE id = $1 RETURNING *',
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Review not found' });
    }
    res.status(200).json({ success: true, message: 'Review deleted successfully' });
  } catch (error) {
    console.error('Delete Review Error:', error);
    res.status(500).json({ success: false, error: 'Failed to delete review' });
  }
};