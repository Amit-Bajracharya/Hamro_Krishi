const express = require('express');
const router = express.Router();
const {
  createNotification,
  getNotificationsByUser,
  getNotificationById,
  markAsRead,
  markAllAsRead,
  deleteNotification,
  deleteAllForUser,
} = require('../controllers/notificationController');

// Must be before /:id to avoid route conflicts
router.get('/user/:user_id',          getNotificationsByUser);
router.patch('/user/:user_id/read-all', markAllAsRead);
router.delete('/user/:user_id',       deleteAllForUser);

router.post('/',                      createNotification);
router.get('/:id',                    getNotificationById);
router.patch('/:id/read',             markAsRead);
router.delete('/:id',                 deleteNotification);

module.exports = router;