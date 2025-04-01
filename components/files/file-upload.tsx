"use client";

import { useState, useEffect } from "react";
import { Upload, Loader2 } from "lucide-react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { useProjectFiles } from "@/lib/supabase/files-adapter";

interface FileUploadProps {
  projectId: string;
  onUploadComplete?: () => void;
}

export function FileUpload({ projectId, onUploadComplete }: FileUploadProps) {
  const [isUploading, setIsUploading] = useState(false);
  const [userId, setUserId] = useState<string | null>(null);
  const supabase = createClientComponentClient();
  const { ensureProjectMembership } = useProjectFiles();

  // Get current user ID
  useEffect(() => {
    const getUserId = async () => {
      const {
        data: { session },
      } = await supabase.auth.getSession();
      const currentUserId = session?.user?.id || null;
      setUserId(currentUserId);
    };
    getUserId();
  }, [supabase]);

  const handleFileUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    if (!userId) {
      toast.error("User not authenticated. Please log in again.");
      return;
    }

    setIsUploading(true);

    try {
      // Get fresh session
      const {
        data: { session },
      } = await supabase.auth.getSession();
      const freshUserId = session?.user?.id;

      if (!freshUserId) {
        throw new Error("No user ID found in session");
      }

      console.log(`FileUpload - Uploading files for project ${projectId} as user ${freshUserId}`);

      // Ensure project membership
      const membershipSuccess = await ensureProjectMembership(freshUserId, projectId);
      
      if (!membershipSuccess) {
        console.warn(`User ${freshUserId} is not a member of project ${projectId} and not the owner`);
        toast.error("You don't have permission to upload files to this project");
        return;
      }

      // Upload each file
      let uploadedFiles = 0;
      for (const file of files) {
        try {
          // Generate a unique file path
          const fileExt = file.name.split(".").pop();
          const fileName = `${Date.now()}-${Math.random().toString(36).substring(2, 15)}.${fileExt}`;
          const filePath = `${projectId}/${fileName}`;

          console.log(`FileUpload - Uploading file ${file.name} to ${filePath}`);

          // Upload to storage
          const { error: uploadError } = await supabase.storage
            .from("project-files")
            .upload(filePath, file);

          if (uploadError) {
            console.error("Storage upload error:", uploadError);
            throw uploadError;
          }

          // Create file record in database
          const fileData = {
            name: file.name,
            size: file.size,
            mime_type: file.type,
            storage_path: filePath,
            project_id: projectId,
            uploaded_by: freshUserId,
          };

          console.log(`FileUpload - Creating file record:`, fileData);

          const { error: dbError } = await supabase
            .from("files")
            .insert(fileData);

          if (dbError) {
            console.error("Database insert error:", dbError);
            throw dbError;
          }

          uploadedFiles++;
          toast.success(`File "${file.name}" uploaded successfully`);
        } catch (fileError) {
          console.error(`Error uploading file "${file.name}":`, fileError);
          toast.error(
            `Failed to upload "${file.name}": ${fileError.message || "Unknown error"}`,
          );
        }
      }

      // Reset file input
      if (e.target) {
        e.target.value = "";
      }

      // Notify parent component to refresh files
      if (uploadedFiles > 0) {
        console.log("FileUpload - Upload completed successfully, calling onUploadComplete callback");
        if (onUploadComplete) {
          onUploadComplete();
        } else {
          console.warn("FileUpload - onUploadComplete callback is not provided");
          // Force refresh as fallback if no callback provided
          window.location.reload();
        }
      } else {
        console.warn("FileUpload - No files were uploaded successfully");
      }
    } catch (error) {
      console.error("Error in file upload process:", error);
      toast.error(
        "Failed to upload files: " + (error.message || "Unknown error"),
      );
    } finally {
      setIsUploading(false);
    }
  };

  return (
    <div className="flex items-center gap-4">
      <Input
        type="file"
        multiple
        onChange={handleFileUpload}
        disabled={isUploading}
        className="hidden"
        id="file-upload"
      />
      <Button
        variant="outline"
        onClick={() => document.getElementById("file-upload")?.click()}
        disabled={isUploading}
      >
        {isUploading ? (
          <>
            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            Uploading...
          </>
        ) : (
          <>
            <Upload className="mr-2 h-4 w-4" />
            Upload Files
          </>
        )}
      </Button>
    </div>
  );
}

