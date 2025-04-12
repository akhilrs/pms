// components/milestones/project-milestones-wrapper.tsx
"use client";

import { useEffect, useState, useCallback } from "react";
import { toast } from "sonner";
import { MilestoneList } from "./milestone-list";
import { Plus } from "lucide-react";
import { Button } from "@/components/ui/button";

export function ProjectMilestonesWrapper({ projectId }: { projectId: string }) {
  const [milestones, setMilestones] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const loadMilestones = useCallback(async () => {
    try {
      setLoading(true);
      const response = await fetch(`/api/projects/${projectId}/milestones`);

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || "Failed to load milestones");
      }

      const { data } = await response.json();
      setMilestones(data || []);
    } catch (error) {
      toast.error("Failed to load milestones", {
        description: "Please try again later",
      });
      console.error("Error loading milestones:", error);
    } finally {
      setLoading(false);
    }
  }, [projectId]);

  useEffect(() => {
    loadMilestones();
  }, [projectId, loadMilestones]);

  if (loading) {
    return <div className="text-center py-8">Loading milestones...</div>;
  }

  return (
    <div>
      <MilestoneList 
        projectId={projectId} 
        milestones={milestones} 
        onMilestoneChange={loadMilestones} 
      />
    </div>
  );
}
