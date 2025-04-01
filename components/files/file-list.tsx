"use client";

import { useState } from "react";
import { File, Download, Trash2, Loader2 } from "lucide-react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { createClientComponentClient } from "@supabase/auth-helpers-nextjs";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog";

interface FileListProps {
  projectId: string;
  files: Array<{
    id: string;
    name: string;
    size: number;
    mime_type: string;
    storage_path: string;
    created_at: string;
  }>;
  onFileDelete?: () => void;
}

export function FileList({ projectId, files, onFileDelete }: FileListProps) {
  const [isDeleting, setIsDeleting] = useState<string | null>(null);
  const supabase = createClientComponentClient();

  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return "0 Bytes";
    const k = 1024;
    const sizes = ["Bytes", "KB", "MB", "GB"];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
  };

  const handleDownload = async (file: FileListProps["files"][0]) => {
    try {
      const { data, error } = await supabase.storage
        .from("project-files")
        .download(file.storage_path);

      if (error) throw error;

      // Create a blob from the file data
      const blob = new Blob([data], { type: file.mime_type });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = file.name;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
    } catch (error) {
      console.error("Error downloading file:", error);
      toast.error("Failed to download file");
    }
  };

  const handleDelete = async (fileId: string, storagePath: string) => {
    setIsDeleting(fileId);

    try {
      // Delete from storage
      const { error: storageError } = await supabase.storage
        .from("project-files")
        .remove([storagePath]);

      if (storageError) throw storageError;

      // Delete from database
      const { error: dbError } = await supabase
        .from("files")
        .delete()
        .eq("id", fileId);

      if (dbError) throw dbError;

      toast.success("File deleted successfully");

      // Call the onFileDelete callback
      if (onFileDelete) {
        console.log("Calling onFileDelete callback");
        onFileDelete();
      }
    } catch (error) {
      console.error("Error deleting file:", error);
      toast.error("Failed to delete file");
    } finally {
      setIsDeleting(null);
    }
  };

  return (
    <div className="space-y-4">
      {files.length === 0 ? (
        <p className="text-center text-gray-500 py-4">No files found</p>
      ) : (
        files.map((file) => (
          <div
            key={file.id}
            className="flex items-center justify-between p-4 border rounded-lg"
          >
            <div className="flex items-center gap-3">
              <File className="h-5 w-5 text-gray-500" />
              <div>
                <p className="font-medium">{file.name}</p>
                <p className="text-sm text-gray-500">
                  {formatFileSize(file.size)} •{" "}
                  {new Date(file.created_at).toLocaleDateString()}
                </p>
              </div>
            </div>
            <div className="flex items-center gap-2">
              <Button
                variant="ghost"
                size="icon"
                onClick={() => handleDownload(file)}
              >
                <Download className="h-4 w-4" />
              </Button>
              <AlertDialog>
                <AlertDialogTrigger asChild>
                  <Button
                    variant="ghost"
                    size="icon"
                    disabled={isDeleting === file.id}
                  >
                    {isDeleting === file.id ? (
                      <Loader2 className="h-4 w-4 animate-spin" />
                    ) : (
                      <Trash2 className="h-4 w-4" />
                    )}
                  </Button>
                </AlertDialogTrigger>
                <AlertDialogContent>
                  <AlertDialogHeader>
                    <AlertDialogTitle>Delete File</AlertDialogTitle>
                    <AlertDialogDescription>
                      Are you sure you want to delete this file? This action
                      cannot be undone.
                    </AlertDialogDescription>
                  </AlertDialogHeader>
                  <AlertDialogFooter>
                    <AlertDialogCancel>Cancel</AlertDialogCancel>
                    <AlertDialogAction
                      onClick={() => handleDelete(file.id, file.storage_path)}
                      className="bg-destructive text-destructive-foreground hover:bg-destructive/90"
                    >
                      Delete
                    </AlertDialogAction>
                  </AlertDialogFooter>
                </AlertDialogContent>
              </AlertDialog>
            </div>
          </div>
        ))
      )}
    </div>
  );
}

