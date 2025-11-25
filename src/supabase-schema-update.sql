-- =====================================================
-- EXAMUPDT ADMIN PANEL - SCHEMA UPDATE
-- =====================================================
-- Run this in your Supabase SQL Editor to update your database schema
-- This adds the missing columns if they don't exist

-- Add exam_dates column to posts table if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'posts' AND column_name = 'exam_dates'
    ) THEN
        ALTER TABLE posts ADD COLUMN exam_dates JSONB DEFAULT '[]'::jsonb;
    END IF;
END $$;

-- Add external_link column to posts table if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'posts' AND column_name = 'external_link'
    ) THEN
        ALTER TABLE posts ADD COLUMN external_link TEXT;
    END IF;
END $$;

-- Add timetable_link column to posts table if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'posts' AND column_name = 'timetable_link'
    ) THEN
        ALTER TABLE posts ADD COLUMN timetable_link TEXT;
    END IF;
END $$;

-- Add server1_link column to results table if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'results' AND column_name = 'server1_link'
    ) THEN
        ALTER TABLE results ADD COLUMN server1_link TEXT;
    END IF;
END $$;

-- Add server2_link column to results table if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'results' AND column_name = 'server2_link'
    ) THEN
        ALTER TABLE results ADD COLUMN server2_link TEXT;
    END IF;
END $$;

-- Refresh the schema cache
NOTIFY pgrst, 'reload schema';

-- =====================================================
-- VERIFICATION QUERY
-- =====================================================
-- Run this to verify the columns were added successfully
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name IN ('posts', 'results')
  AND column_name IN ('exam_dates', 'external_link', 'timetable_link', 'server1_link', 'server2_link')
ORDER BY table_name, ordinal_position;
