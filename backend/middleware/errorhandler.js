const errorHandler = (err, req, res, next) => {
  console.error(err.stack);

  // Supabase / PostgreSQL unique violation
  if (err.code === '23505') {
    return res.status(409).json({ error: 'A customer with this email already exists' });
  }

  // Foreign key violation (auth.users)
  if (err.code === '23503') {
    return res.status(400).json({ error: 'Referenced user does not exist in auth.users' });
  }

  const statusCode = err.statusCode || 500;
  res.status(statusCode).json({
    error: err.message || 'Internal server error',
  });
};

module.exports = errorHandler;