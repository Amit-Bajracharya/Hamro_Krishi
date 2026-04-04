const express = require('express');
const router = express.Router();
const {
  createReview,
  getAllReviews,
  getReviewById,
  getReviewsByTarget,
  getReviewsByReviewer,
  deleteReview,
} = require('../controllers/reviewController');

router.get('/target/:target_id',     getReviewsByTarget);   // before /:id
router.get('/reviewer/:reviewer_id', getReviewsByReviewer); // before /:id
router.get('/',                      getAllReviews);
router.post('/',                     createReview);
router.get('/:id',                   getReviewById);
router.delete('/:id',                deleteReview);

module.exports = router;