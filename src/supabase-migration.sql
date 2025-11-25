-- =====================================================
-- EXAMUPDT - DATABASE MIGRATION SCRIPT
-- =====================================================
-- Run this in Supabase SQL Editor to add new fields to existing database
-- This is safe to run multiple times (uses IF NOT EXISTS checks)

-- =====================================================
-- ADD NEW COLUMNS TO posts TABLE
-- =====================================================

-- Add external_link column if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'posts' AND column_name = 'external_link') THEN
        ALTER TABLE posts ADD COLUMN external_link TEXT;
        RAISE NOTICE 'Added external_link column to posts table';
    ELSE
        RAISE NOTICE 'external_link column already exists in posts table';
    END IF;
END $$;

-- Add timetable_link column if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'posts' AND column_name = 'timetable_link') THEN
        ALTER TABLE posts ADD COLUMN timetable_link TEXT;
        RAISE NOTICE 'Added timetable_link column to posts table';
    ELSE
        RAISE NOTICE 'timetable_link column already exists in posts table';
    END IF;
END $$;

-- Add exam_dates column if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_name = 'posts' AND column_name = 'exam_dates') THEN
        ALTER TABLE posts ADD COLUMN exam_dates JSONB DEFAULT '[]'::jsonb;
        RAISE NOTICE 'Added exam_dates column to posts table';
    ELSE
        RAISE NOTICE 'exam_dates column already exists in posts table';
    END IF;
END $$;

-- =====================================================
-- VERIFY MIGRATION
-- =====================================================
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'posts' 
  AND column_name IN ('external_link', 'timetable_link', 'exam_dates')
ORDER BY column_name;

-- =====================================================
-- NOTES
-- =====================================================
-- This migration adds three new optional fields to the posts table:
-- 1. external_link (TEXT) - Optional external link for "OPEN" button
-- 2. timetable_link (TEXT) - Optional timetable download link
-- 3. exam_dates (JSONB) - Array of {subject, date} objects for exam schedule
--
-- All existing posts will have these fields set to NULL or empty array by default
-- The migration is non-destructive and preserves all existing data
