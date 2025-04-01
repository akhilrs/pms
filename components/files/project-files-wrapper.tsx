"use client";

import { Suspense, lazy } from "react";
import dynamic from "next/dynamic";

// Lazy load the ProjectFiles component
const ProjectFilesComponent = dynamic(
  () => import("./project-files").then(mod => mod.ProjectFiles),
  { 
    ssr: false,
    loading: () => <div className="py-10 text-center">Loading files...</div>
  }
);

interface ProjectFilesWrapperProps {
  projectId: string;
}

export function ProjectFilesWrapper({ projectId }: ProjectFilesWrapperProps) {
  return (
    <Suspense fallback={<div className="py-10 text-center">Loading files...</div>}>
      <ProjectFilesComponent projectId={projectId} />
    </Suspense>
  );
} 