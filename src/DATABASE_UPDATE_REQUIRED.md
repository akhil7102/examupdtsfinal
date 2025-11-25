# 🔧 Database Schema Update Required

## Issue
The error `"Could not find the 'exam_dates' column of 'posts' in the schema cache"` indicates that your Supabase database is missing the updated schema columns for the new features.

## Solution
You need to run the schema update SQL script in your Supabase SQL Editor.

## Steps to Update Your Database

### 1. Access Supabase SQL Editor
1. Go to your Supabase Dashboard: https://supabase.com/dashboard
2. Select your project
3. Click on **SQL Editor** in the left sidebar
4. Click **New Query**

### 2. Run the Schema Update Script
1. Open the file `/supabase-schema-update.sql` in this project
2. Copy the entire contents of the file
3. Paste it into the Supabase SQL Editor
4. Click **Run** or press `Ctrl+Enter` (Windows) / `Cmd+Enter` (Mac)

### 3. Verify the Update
After running the script, you should see a success message. The script will:
- ✅ Add `exam_dates` column to the `posts` table
- ✅ Add `external_link` column to the `posts` table
- ✅ Add `timetable_link` column to the `posts` table
- ✅ Add `server1_link` column to the `results` table
- ✅ Add `server2_link` column to the `results` table
- ✅ Refresh the schema cache

### 4. Test Your Application
1. Reload your application
2. Try creating a new post from the Admin Panel
3. The errors should now be resolved

## What Changed

### Posts Table (Notifications)
- **exam_dates**: Stores exam schedule as an array of subject-date pairs
- **external_link**: Optional external link that appears as "OPEN" button
- **timetable_link**: Optional timetable download link

### Results Table
- **server1_link**: Primary server link for result downloads
- **server2_link**: Alternative server link for result downloads

## Alternative: Fresh Schema Install
If you prefer to start fresh or encounter issues, you can:
1. Delete all existing tables in Supabase
2. Run the complete schema from `/supabase-schema.sql`

⚠️ **Warning**: This will delete all existing data. Only do this if you have backups or if your database is empty.

## Need Help?
If you encounter any issues:
1. Check the Supabase logs for detailed error messages
2. Ensure you have the correct permissions to modify the schema
3. Verify that Row Level Security (RLS) policies are properly configured
