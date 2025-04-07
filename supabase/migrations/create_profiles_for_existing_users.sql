-- This will create missing profiles for existing users

-- First, create the function if it doesn't exist (copied from recreate_database.sql)
CREATE OR REPLACE FUNCTION create_profile_for_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, user_id, first_name, last_name, avatar_url, created_at, updated_at)
  VALUES (NEW.id, NEW.id, '', '', '', NOW(), NOW());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop the trigger if it exists
DROP TRIGGER IF EXISTS create_profile_on_signup ON auth.users;

-- Create trigger to auto-create profiles for new users
CREATE TRIGGER create_profile_on_signup
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION create_profile_for_new_user();

-- Now create profiles for any existing users that don't have one

-- First, get all users without profiles
DO $$
DECLARE
  user_record RECORD;
BEGIN
  FOR user_record IN 
    SELECT au.id 
    FROM auth.users au
    LEFT JOIN public.profiles p ON au.id = p.user_id
    WHERE p.id IS NULL
  LOOP
    -- Insert a profile for each user that doesn't have one
    INSERT INTO public.profiles (id, user_id, first_name, last_name, avatar_url, created_at, updated_at)
    VALUES (user_record.id, user_record.id, '', '', '', NOW(), NOW());
    
    RAISE NOTICE 'Created profile for user %', user_record.id;
  END LOOP;
END;
$$;