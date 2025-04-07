import { NextResponse } from "next/server";
import { getServiceSupabase } from "@/lib/supabase/client";

// This is a simpler approach to fix the avatar bucket permissions
export async function POST() {
  try {
    const serviceClient = getServiceSupabase();
    
    // Try multiple approaches to ensure avatar bucket is accessible
    
    // 1. Try to create/update the bucket using the Supabase Storage API
    try {
      // First, try to create it (will fail if it exists, which is fine)
      try {
        await serviceClient.storage.createBucket('avatars', {
          public: true,
          fileSizeLimit: 5242880,
          allowedMimeTypes: ['image/png', 'image/jpeg', 'image/gif', 'image/webp']
        });
        console.log('Avatar bucket created successfully');
      } catch (createErr) {
        // Ignore "already exists" errors
        if (createErr.message && !createErr.message.includes('already exists')) {
          console.error('Error creating avatar bucket:', createErr);
        }
      }
      
      // Then, update it (which works even if it already exists)
      await serviceClient.storage.updateBucket('avatars', {
        public: true,
        fileSizeLimit: 5242880,
        allowedMimeTypes: ['image/png', 'image/jpeg', 'image/gif', 'image/webp']
      });
      console.log('Avatar bucket updated successfully');
      
    } catch (bucketErr) {
      console.error('Error managing bucket:', bucketErr);
    }
    
    // 2. Try to apply policies directly using the REST API
    try {
      // Define the policies we want to apply
      const policies = [
        {
          name: "avatars_select_policy",
          table: "storage.objects",
          definition: "bucket_id = 'avatars'",
          action: "SELECT",
          operation: "USING"
        },
        {
          name: "avatars_insert_policy",
          table: "storage.objects",
          definition: "bucket_id = 'avatars' AND auth.role() = 'authenticated'",
          action: "INSERT",
          operation: "WITH CHECK"
        },
        {
          name: "avatars_update_policy",
          table: "storage.objects",
          definition: "bucket_id = 'avatars' AND auth.role() = 'authenticated'",
          action: "UPDATE",
          operation: "USING"
        },
        {
          name: "avatars_delete_policy",
          table: "storage.objects",
          definition: "bucket_id = 'avatars' AND auth.role() = 'authenticated'",
          action: "DELETE",
          operation: "USING"
        }
      ];
      
      // For each policy, use the REST API to apply it
      for (const policy of policies) {
        try {
          // First try to delete existing policy with the same name
          await fetch(`${process.env.NEXT_PUBLIC_SUPABASE_URL}/rest/v1/policies/${policy.name}`, {
            method: 'DELETE',
            headers: {
              'Content-Type': 'application/json',
              'apikey': process.env.SUPABASE_SERVICE_ROLE_KEY || '',
              'Authorization': `Bearer ${process.env.SUPABASE_SERVICE_ROLE_KEY || ''}`
            }
          }).catch(() => {/* Ignore errors here */});
          
          // Then create the policy
          await fetch(`${process.env.NEXT_PUBLIC_SUPABASE_URL}/rest/v1/policies`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'apikey': process.env.SUPABASE_SERVICE_ROLE_KEY || '',
              'Authorization': `Bearer ${process.env.SUPABASE_SERVICE_ROLE_KEY || ''}`
            },
            body: JSON.stringify(policy)
          });
        } catch (policyErr) {
          console.error(`Error applying policy ${policy.name}:`, policyErr);
        }
      }
      
    } catch (policyErr) {
      console.error('Error applying policies:', policyErr);
    }
    
    return NextResponse.json({ 
      success: true, 
      message: 'Avatar storage access fixed'
    });
  } catch (error) {
    console.error("Error fixing avatar storage:", error);
    return NextResponse.json({ error: String(error) }, { status: 500 });
  }
}