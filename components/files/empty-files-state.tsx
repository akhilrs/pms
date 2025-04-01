"use client";

import { FileUpload } from "./file-upload";

interface EmptyFilesStateProps {
  projectId: string;
  onFileUploadComplete: () => void;
}

export function EmptyFilesState({ projectId, onFileUploadComplete }: EmptyFilesStateProps) {
  return (
    <div className="text-center py-12 border-2 border-dashed rounded-lg">
      <h3 className="text-lg font-medium mb-2">No files yet</h3>
      <p className="text-sm text-gray-500 mb-4">
        Upload files to share with your team
      </p>
      <FileUpload
        projectId={projectId}
        onUploadComplete={onFileUploadComplete}
      />
    </div>
  );
}

