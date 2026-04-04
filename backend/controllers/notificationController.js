const db = require('../db');

const VALID_ROLES = ['farmer', 'middleman', 'customer'];
const VALID_TYPES = ['order', 'contract', 'transaction', 'review', 'general'];

// POST /api/notifications
exports.createNotification = async (req, res) => {
  const { user_id, user_role, title, message, type, reference_id } = req.body;

  if (!user_id || !user_role || !title || !message || !type) {
    return res.status(400).json({
      success: false,
      error: 'user_id, user_role, title, message, and type are required',
    });
  }

  if (!VALID_ROLES.includes(user_role)) {
    return res.status(400).json({
      success: false,
      error: `user_role must be one of: ${VALID_ROLES.join(', ')}`,
    });
  }

  if (!VALID_TYPES.includes(type)) {
    return res.status(400).json({
      success: false,
      error: `type must be one of: ${VALID_TYPES.join(', ')}`,
    });
  }

  try {
    const result = await db.query(
      `INSERT INTO public.notifications (user_id, user_role, title, message, type, reference_id)
       VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [user_id, user_role, title, message, type, reference_id || null]
    );

    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Create Notification Error:', error);
    if (error.code === '23503') {
      return res.status(404).json({ success: false, error: 'Referenced user does not exist.' });
    }
    res.status(500).json({ success: false, error: 'Server error creating notification.' });
  }
};

// GET /api/notifications/user/:user_id
// Optional query param: ?unread=true to filter unread only
exports.getNotificationsByUser = async (req, res) => {
  const { user_id } = req.params;
  const { unread } = req.query;

  try {
    let query = `SELECT * FROM public.notifications WHERE user_id = $1`;
    const values = [user_id];

    if (unread === 'true') {
      query += ` AND is_read = FALSE`;
    }

    query += ` ORDER BY created_at DESC`;

    const result = await db.query(query, values);
    const unreadCount = result.rows.filter((n) => !n.is_read).length;

    res.json({
      success: true,
      count: result.rowCount,
      unread_count: unreadCount,
      data: result.rows,
    });
  } catch (error) {
    console.error('Get Notifications By User Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch notifications.' });
  }
};

// GET /api/notifications/:id
exports.getNotificationById = async (req, res) => {
  try {
    const result = await db.query(
      'SELECT * FROM public.notifications WHERE id = $1',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Notification not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Get Notification By ID Error:', error);
    res.status(500).json({ success: false, error: 'Failed to fetch notification.' });
  }
};

// PATCH /api/notifications/:id/read  — mark single notification as read
exports.markAsRead = async (req, res) => {
  try {
    const result = await db.query(
      `UPDATE public.notifications SET is_read = TRUE WHERE id = $1 RETURNING *`,
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Notification not found.' });
    }
    res.json({ success: true, data: result.rows[0] });
  } catch (error) {
    console.error('Mark As Read Error:', error);
    res.status(500).json({ success: false, error: 'Server error marking notification as read.' });
  }
};

// PATCH /api/notifications/user/:user_id/read-all  — mark all as read for a user
exports.markAllAsRead = async (req, res) => {
  try {
    const result = await db.query(
      `UPDATE public.notifications SET is_read = TRUE
       WHERE user_id = $1 AND is_read = FALSE RETURNING *`,
      [req.params.user_id]
    );
    res.json({
      success: true,
      message: `${result.rowCount} notification(s) marked as read.`,
      updated_count: result.rowCount,
    });
  } catch (error) {
    console.error('Mark All As Read Error:', error);
    res.status(500).json({ success: false, error: 'Server error marking all notifications as read.' });
  }
};

// DELETE /api/notifications/:id
exports.deleteNotification = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.notifications WHERE id = $1 RETURNING *',
      [req.params.id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ success: false, error: 'Notification not found.' });
    }
    res.json({ success: true, message: 'Notification deleted successfully.' });
  } catch (error) {
    console.error('Delete Notification Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting notification.' });
  }
};

// DELETE /api/notifications/user/:user_id  — clear all notifications for a user
exports.deleteAllForUser = async (req, res) => {
  try {
    const result = await db.query(
      'DELETE FROM public.notifications WHERE user_id = $1 RETURNING *',
      [req.params.user_id]
    );
    res.json({
      success: true,
      message: `${result.rowCount} notification(s) deleted.`,
      deleted_count: result.rowCount,
    });
  } catch (error) {
    console.error('Delete All Notifications Error:', error);
    res.status(500).json({ success: false, error: 'Server error deleting notifications.' });
  }
};