const express = require('express');
const router = express.Router();
const reviewController = require('../controllers/reviewController');

// GET  /api/reviews                        — list all (filterable)
router.get('/', reviewController.getAllReviews);

// GET  /api/reviews/target/:target_id      — reviews FOR a farmer/middleman + avg rating
router.get('/target/:target_id', reviewController.getReviewsByTarget);

// GET  /api/reviews/:id                    — single review
router.get('/:id', reviewController.getReviewById);

// POST /api/reviews                        — create review
router.post('/', reviewController.createReview);

// PATCH /api/reviews/:id                   — update rating/comment
router.patch('/:id', reviewController.updateReview);

// DELETE /api/reviews/:id                  — delete review
router.delete('/:id', reviewController.deleteReview);

module.exports = router;