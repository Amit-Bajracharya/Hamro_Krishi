-- Add password_hash columns to role tables for authentication
-- Run this in your PostgreSQL database

-- Add password_hash to farmers table
ALTER TABLE public.farmers ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255);

-- Add password_hash to customers table  
ALTER TABLE public.customers ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255);

-- Add password_hash to middlemen table
ALTER TABLE public.middlemen ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255);

-- Create indexes for faster authentication queries
CREATE INDEX IF NOT EXISTS idx_farmers_email ON public.farmers(email);
CREATE INDEX IF NOT EXISTS idx_customers_email ON public.customers(email);
CREATE INDEX IF NOT EXISTS idx_middlemen_email ON public.middlemen(email);

-- Remove foreign key constraints if they reference auth.users table
ALTER TABLE public.farmers DROP CONSTRAINT IF EXISTS farmers_id_fkey;
ALTER TABLE public.customers DROP CONSTRAINT IF EXISTS customers_id_fkey;  
ALTER TABLE public.middlemen DROP CONSTRAINT IF EXISTS middlemen_id_fkey;
