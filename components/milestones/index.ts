// components/milestones/index.tsx
"use client";

import { useEffect, useState } from 'react';
import { MilestoneList } from './milestone-list';
import { getProjectMilestones } from '@/lib/supabase/milestones';
import { useToast } from '@/components/ui/use-toast';

export function ProjectMilestonesWrapper({ projectId }: { projectId: string }) {
  const [milestones, setMilestones] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const { toast } = useToast();

  const loadMilestones = async () => {
    try {
      setLoading(true);
      const { data, error } = await getProjectMilestones(projectId);
      
      if (error) throw error;
      setMilestones(data || []);
    } catch (error) {
      toast({
        title: "Error", 
        description: "Failed to load milestones",
        variant: "destructive"
      });
      console.error("Error loading milestones:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadMilestones();
  }, [projectId]);

  if (loading) {
    return <div className="text-center py-8">Loading milestones...</div>;
  }

  return (
    <MilestoneList 
      projectId={projectId} 
      milestones={milestones} 
      onMilestoneChange={loadMilestones} 
    />
  );
}
