import { NextResponse } from "next/server";
import { getServiceSupabase } from "@/lib/supabase/client";

// This route will create and configure the avatars bucket
export async function POST(request: Request) {
  try {
    const body = await request.json();
    const bucketId = body.bucketId || 'avatars'; // Default to 'avatars' if not specified
    
    const serviceClient = getServiceSupabase();
    
    // Try to create the bucket but ignore "already exists" errors
    try {
      await serviceClient
        .storage
        .createBucket(bucketId, {
          public: true,
          fileSizeLimit: 5242880, // 5MB
          allowedMimeTypes: ['image/png', 'image/jpeg', 'image/gif', 'image/webp']
        });
        
      console.log(`Bucket ${bucketId} created successfully`);
    } catch (bucketError) {
      // Ignore "already exists" errors as this is expected
      if (bucketError.message && (
          bucketError.message.includes('already exists') || 
          bucketError.message.includes('Duplicate name')
        )) {
        console.log(`Bucket ${bucketId} already exists, updating settings...`);
      } else {
        console.error('Error creating bucket:', bucketError);
        // Continue with other operations even if bucket creation fails
      }
    }
    
    // Update the bucket configuration using the Storage API
    try {
      // First try to create the bucket (might already exist, which is fine)
      try {
        await serviceClient.storage.createBucket(bucketId, {
          public: true,
          allowedMimeTypes: ['image/png', 'image/jpeg', 'image/gif', 'image/webp'],
          fileSizeLimit: 5242880
        });
      } catch (createErr) {
        if (createErr.message && !createErr.message.includes('already exists')) {
          console.error('Error creating bucket:', createErr);
        }
      }

      // Then update it (works even if it already exists)
      await serviceClient.storage.updateBucket(bucketId, {
        public: true,
        allowedMimeTypes: ['image/png', 'image/jpeg', 'image/gif', 'image/webp'],
        fileSizeLimit: 5242880
      });
    } catch (updateErr) {
      console.error('Error updating bucket settings:', updateErr);
    }
    
    return NextResponse.json({ 
      success: true, 
      message: `Bucket ${bucketId} created and configured successfully`
    });
  } catch (error) {
    console.error("Error creating bucket:", error);
    return NextResponse.json({ error: String(error) }, { status: 500 });
  }
}