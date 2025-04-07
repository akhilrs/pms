"use client";

import { useState, useRef } from "react";
import { UploadCloud, X } from "lucide-react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { Database } from "@/types/supabase";
import { useUser } from "@/lib/supabase/auth";

interface AvatarUploadProps {
  onUploadComplete: (url: string) => void;
  currentAvatarUrl?: string;
}

export function AvatarUpload({ 
  onUploadComplete, 
  currentAvatarUrl 
}: AvatarUploadProps) {
  const [isUploading, setIsUploading] = useState(false);
  const [preview, setPreview] = useState<string | null>(currentAvatarUrl || null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const supabase = createClientComponentClient<Database>();
  const { user } = useUser();

  const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file || !user?.id) return;

    try {
      // Validate file type
      if (!file.type.startsWith('image/')) {
        toast.error('Please select an image file');
        return;
      }

      // Validate file size (max 5MB)
      if (file.size > 5 * 1024 * 1024) {
        toast.error('Image must be less than 5MB');
        return;
      }

      // Show preview
      const objectUrl = URL.createObjectURL(file);
      setPreview(objectUrl);

      // Start upload
      setIsUploading(true);
      
      // Upload to Supabase storage
      const userId = user.id;
      const fileName = `avatar-${userId}-${Date.now()}`;
      const { data, error } = await supabase.storage
        .from('avatars')
        .upload(fileName, file, {
          cacheControl: '3600',
          upsert: true
        });

      if (error) {
        console.error('Error uploading avatar:', error);
        toast.error('Failed to upload avatar');
        return;
      }

      // Get public URL
      const { data: urlData } = supabase.storage
        .from('avatars')
        .getPublicUrl(fileName);

      if (urlData?.publicUrl) {
        onUploadComplete(urlData.publicUrl);
        toast.success('Avatar uploaded successfully');
      }
    } catch (error) {
      console.error('Error in avatar upload:', error);
      toast.error('An error occurred while uploading avatar');
    } finally {
      setIsUploading(false);
    }
  };

  const clearAvatar = () => {
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
    setPreview(null);
    onUploadComplete('');
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-center">
        {preview ? (
          <div className="relative">
            <img 
              src={preview} 
              alt="Avatar preview" 
              className="w-32 h-32 rounded-full object-cover"
            />
            <button 
              type="button"
              onClick={clearAvatar}
              className="absolute top-0 right-0 bg-red-500 text-white rounded-full p-1 transform translate-x-1/3 -translate-y-1/3"
            >
              <X className="h-4 w-4" />
            </button>
          </div>
        ) : (
          <div className="w-32 h-32 flex items-center justify-center border-2 border-dashed border-gray-300 rounded-full bg-gray-50">
            <UploadCloud className="h-10 w-10 text-gray-400" />
          </div>
        )}
      </div>

      <div className="flex justify-center">
        <input
          type="file"
          ref={fileInputRef}
          onChange={handleFileChange}
          accept="image/*"
          className="hidden"
        />
        <Button 
          type="button" 
          variant="outline" 
          onClick={() => fileInputRef.current?.click()}
          disabled={isUploading}
        >
          {isUploading ? 'Uploading...' : 'Upload Avatar'}
        </Button>
      </div>
    </div>
  );
}