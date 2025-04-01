"use client";

import { useState, useEffect } from "react";
import { useProjectFiles } from "@/lib/supabase/files-adapter";
import { FileUpload } from "./file-upload";
import { FileList } from "./file-list";
import { UploadCloud, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import { toast } from "sonner";

interface ProjectFilesProps {
  projectId: string;
}

export function ProjectFiles({ projectId }: ProjectFilesProps) {
  const [files, setFiles] = useState([]);
  const [loading, setLoading] = useState(true);
  const { getProjectFiles, ensureProjectMembership } = useProjectFiles();
  const supabase = createClientComponentClient();
  const [isUploading, setIsUploading] = useState(false);

  // Client-side fetch function using the adapter
  const fetchFiles = async () => {
    setLoading(true);
    try {
      console.log("ProjectFiles - Fetching files for project:", projectId);
      // Use the client-side function from files-adapter
      const filesData = await getProjectFiles(projectId);
      console.log(
        `ProjectFiles - Found ${filesData?.length || 0} files for project:`,
        projectId,
      );
      setFiles(filesData || []);
    } catch (error) {
      console.error("ProjectFiles - Error fetching files:", error);
      toast.error("Error fetching files");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (projectId) {
      fetchFiles();
    }
  }, [projectId]);

  const onFileUploadComplete = () => {
    console.log("ProjectFiles - File upload complete, refreshing files list");
    fetchFiles();
  };

  const onFileDelete = () => {
    console.log("ProjectFiles - File deleted, refreshing files list");
    fetchFiles();
  };

  // Handle direct file upload in empty state
  const handleEmptyStateFileUpload = async (
    e: React.ChangeEvent<HTMLInputElement>,
  ) => {
    const files = e.target.files;
    if (!files || files.length === 0) return;

    setIsUploading(true);

    try {
      // Get current user
      const {
        data: { session },
      } = await supabase.auth.getSession();
      const userId = session?.user?.id;

      if (!userId) {
        toast.error("Not authenticated. Please log in to upload files.");
        return;
      }

      // Ensure user is a project member
      const membershipSuccess = await ensureProjectMembership(
        userId,
        projectId,
      );
      if (!membershipSuccess) {
        toast.error(
          "You don't have permission to upload files to this project",
        );
        return;
      }

      // Upload files
      let successCount = 0;
      for (const file of files) {
        try {
          // Generate unique file path
          const fileExt = file.name.split(".").pop();
          const fileName = `${Date.now()}-${Math.random().toString(36).substring(2, 7)}.${fileExt}`;
          const filePath = `${projectId}/${fileName}`;

          console.log(`Uploading file ${file.name} to ${filePath}`);

          // Upload to storage
          const { error: uploadError } = await supabase.storage
            .from("project-files")
            .upload(filePath, file);

          if (uploadError) {
            console.error("Storage upload error:", uploadError);
            throw uploadError;
          }

          // Create database record
          const fileData = {
            name: file.name,
            size: file.size,
            mime_type: file.type,
            storage_path: filePath,
            project_id: projectId,
            uploaded_by: userId,
          };

          console.log("Creating file record:", fileData);

          const { error: dbError } = await supabase
            .from("files")
            .insert(fileData);

          if (dbError) {
            console.error("Database insert error:", dbError);
            throw dbError;
          }

          successCount++;
          toast.success(`File "${file.name}" uploaded successfully`);
        } catch (fileError) {
          console.error(`Error uploading file ${file.name}:`, fileError);
          toast.error(
            `Failed to upload "${file.name}": ${fileError.message || "Unknown error"}`,
          );
        }
      }

      if (successCount > 0) {
        console.log(`Successfully uploaded ${successCount} files`);
        fetchFiles(); // Refresh the file list
      }
    } catch (error) {
      console.error("Error handling file upload:", error);
      toast.error(`Error uploading files: ${error.message || "Unknown error"}`);
    } finally {
      setIsUploading(false);
      e.target.value = "";
    }
  };

  if (loading) {
    return (
      <div className="py-10 text-center">
        <Loader2 className="h-8 w-8 animate-spin mx-auto text-gray-400" />
        <p className="mt-2 text-gray-500">Loading files...</p>
      </div>
    );
  }

  const hasFiles = files && files.length > 0;

  if (!hasFiles) {
    return (
      <div className="text-center py-12 border-2 border-dashed border-gray-300 rounded-lg">
        <UploadCloud className="mx-auto h-12 w-12 text-gray-400" />
        <h3 className="mt-4 text-lg font-medium">No files uploaded yet</h3>
        <p className="mt-2 text-sm text-gray-500">
          Upload files to share with your team
        </p>
        <Input
          type="file"
          multiple
          onChange={handleEmptyStateFileUpload}
          disabled={isUploading}
          className="hidden"
          id="empty-file-upload"
        />
        <Button
          className="mt-6"
          variant="outline"
          onClick={() => document.getElementById("empty-file-upload")?.click()}
          disabled={isUploading}
        >
          {isUploading ? (
            <>
              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
              Uploading...
            </>
          ) : (
            "Upload Files"
          )}
        </Button>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <h3 className="text-lg font-medium">Project Files ({files.length})</h3>
        <FileUpload
          projectId={projectId}
          onUploadComplete={onFileUploadComplete}
        />
      </div>
      <FileList
        projectId={projectId}
        files={files}
        onFileDelete={onFileDelete}
      />
    </div>
  );
}
