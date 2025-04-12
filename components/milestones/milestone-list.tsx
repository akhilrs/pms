// components/milestones/milestone-list.tsx
"use client";

import { useState } from "react";
import {
  Plus,
  ChevronRight,
  ChevronDown,
  Clock,
  Edit,
  Trash2,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { format } from "date-fns";
import { toast } from "sonner";
import { MilestoneForm } from "./milestone-form";
import { MilestoneTasks } from "./milestone-tasks";
import { 
  createMilestoneAction, 
  updateMilestoneAction, 
  deleteMilestoneAction 
} from "@/app/projects/actions";
import { MilestoneWithTasks } from "@/lib/supabase/milestones";

interface MilestoneListProps {
  projectId: string;
  milestones: MilestoneWithTasks[];
  onMilestoneChange: () => void;
}

export function MilestoneList({
  projectId,
  milestones,
  onMilestoneChange,
}: MilestoneListProps) {
  const [openMilestones, setOpenMilestones] = useState<string[]>([]);
  const [createDialogOpen, setCreateDialogOpen] = useState(false);
  const [editMilestone, setEditMilestone] = useState<MilestoneWithTasks | null>(
    null,
  );
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [milestoneToDelete, setMilestoneToDelete] =
    useState<MilestoneWithTasks | null>(null);

  const toggleMilestone = (id: string) => {
    setOpenMilestones((prev) =>
      prev.includes(id) ? prev.filter((item) => item !== id) : [...prev, id],
    );
  };

  const handleCreateMilestone = async (data: any) => {
    try {
      const { error } = await createMilestoneAction({
        project_id: projectId,
        title: data.title,
        description: data.description,
        due_date: data.due_date,
        status: data.status || "Not Started",
      });

      if (error) throw error;

      toast.success("Milestone created successfully");
      setCreateDialogOpen(false);
      onMilestoneChange();
    } catch (error) {
      toast.error("Failed to create milestone");
      console.error("Error creating milestone:", error);
    }
  };

  const handleUpdateMilestone = async (data: any) => {
    if (!editMilestone) return;

    try {
      const { error } = await updateMilestoneAction(editMilestone.id, {
        title: data.title,
        description: data.description,
        due_date: data.due_date,
        status: data.status,
      }, projectId);

      if (error) throw error;

      toast.success("Milestone updated successfully");

      setEditMilestone(null);
      onMilestoneChange();
    } catch (error) {
      toast.error("Failed to update milestone");
      console.error("Error updating milestone:", error);
    }
  };

  const handleDeleteMilestone = async () => {
    if (!milestoneToDelete) return;

    try {
      const { error } = await deleteMilestoneAction(milestoneToDelete.id, projectId);

      if (error) throw error;

      toast.success("Milestone deleted successfully");

      setMilestoneToDelete(null);
      setDeleteDialogOpen(false);
      onMilestoneChange();
    } catch (error) {
      toast.error("Failed to delete milestone");
      console.error("Error deleting milestone:", error);
    }
  };

  const confirmDelete = (milestone: MilestoneWithTasks) => {
    setMilestoneToDelete(milestone);
    setDeleteDialogOpen(true);
  };

  const calculateProgress = (tasks: any[]) => {
    if (!tasks.length) return 0;
    const completed = tasks.filter(
      (task) => task.status === "Completed",
    ).length;
    return Math.round((completed / tasks.length) * 100);
  };

  const getStatusBadgeClass = (status: string) => {
    switch (status) {
      case "Completed":
        return "bg-green-50 text-green-700 border-green-300";
      case "In Progress":
        return "bg-blue-50 text-blue-700 border-blue-300";
      case "Not Started":
        return "bg-gray-50 text-gray-700 border-gray-300";
      default:
        return "bg-gray-50 text-gray-700 border-gray-300";
    }
  };

  return (
    <div>
      <div className="flex justify-between mb-6">
        <h2 className="text-lg font-medium">Project Milestones</h2>
        <Button onClick={() => setCreateDialogOpen(true)}>
          <Plus className="h-4 w-4 mr-2" /> Create Milestone
        </Button>
      </div>

      {milestones.length === 0 ? (
        <div className="text-center py-16 bg-gray-50 rounded-md border">
          <h3 className="text-lg font-medium mb-2">No milestones yet</h3>
          <p className="text-gray-500 mb-6">
            Create milestones to organize your project tasks
          </p>
          <Button onClick={() => setCreateDialogOpen(true)}>
            <Plus className="h-4 w-4 mr-2" /> Create Milestone
          </Button>
        </div>
      ) : (
        <div className="space-y-4">
          {milestones.map((milestone) => (
            <Collapsible
              key={milestone.id}
              open={openMilestones.includes(milestone.id)}
              onOpenChange={() => toggleMilestone(milestone.id)}
              className="border rounded-md"
            >
              <CollapsibleTrigger asChild>
                <div className="p-4 flex justify-between items-center cursor-pointer hover:bg-gray-50">
                  <div className="flex items-center">
                    {openMilestones.includes(milestone.id) ? (
                      <ChevronDown className="h-5 w-5 mr-2 text-gray-400 flex-shrink-0" />
                    ) : (
                      <ChevronRight className="h-5 w-5 mr-2 text-gray-400 flex-shrink-0" />
                    )}
                    <div>
                      <div className="font-medium">{milestone.title}</div>
                      {milestone.description && (
                        <div className="text-sm text-gray-500">
                          {milestone.description}
                        </div>
                      )}
                    </div>
                  </div>

                  <div className="flex items-center gap-4">
                    <Badge
                      variant="outline"
                      className={getStatusBadgeClass(milestone.status)}
                    >
                      {milestone.status}
                    </Badge>

                    {milestone.due_date && (
                      <div className="text-sm text-gray-500 flex items-center">
                        <Clock className="h-4 w-4 mr-1" />
                        {format(new Date(milestone.due_date), "MMM d, yyyy")}
                      </div>
                    )}

                    <div className="flex items-center">
                      <Progress
                        value={calculateProgress(milestone.tasks)}
                        className="w-24 h-2 mr-2"
                      />
                      <span className="text-sm text-gray-500">
                        {calculateProgress(milestone.tasks)}%
                      </span>
                    </div>

                    <div className="flex gap-1">
                      <Button
                        variant="ghost"
                        size="icon"
                        onClick={(e) => {
                          e.stopPropagation();
                          setEditMilestone(milestone);
                        }}
                      >
                        <Edit className="h-4 w-4" />
                      </Button>
                      <Button
                        variant="ghost"
                        size="icon"
                        className="text-red-500 hover:text-red-700"
                        onClick={(e) => {
                          e.stopPropagation();
                          confirmDelete(milestone);
                        }}
                      >
                        <Trash2 className="h-4 w-4" />
                      </Button>
                    </div>
                  </div>
                </div>
              </CollapsibleTrigger>

              <CollapsibleContent>
                <div className="p-4 border-t bg-gray-50">
                  <MilestoneTasks
                    projectId={projectId}
                    milestone={milestone}
                    onTasksChange={onMilestoneChange}
                  />
                </div>
              </CollapsibleContent>
            </Collapsible>
          ))}
        </div>
      )}

      {/* Create Milestone Dialog */}
      <Dialog open={createDialogOpen} onOpenChange={setCreateDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Create Milestone</DialogTitle>
            <DialogDescription>
              Add a new milestone to track your project's progress
            </DialogDescription>
          </DialogHeader>
          <MilestoneForm
            onSubmit={handleCreateMilestone}
            onCancel={() => setCreateDialogOpen(false)}
          />
        </DialogContent>
      </Dialog>

      {/* Edit Milestone Dialog */}
      <Dialog
        open={editMilestone !== null}
        onOpenChange={(open) => !open && setEditMilestone(null)}
      >
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Edit Milestone</DialogTitle>
            <DialogDescription>Update milestone details</DialogDescription>
          </DialogHeader>
          {editMilestone && (
            <MilestoneForm
              defaultValues={{
                title: editMilestone.title,
                description: editMilestone.description || "",
                due_date: editMilestone.due_date
                  ? new Date(editMilestone.due_date)
                  : undefined,
                status: editMilestone.status,
              }}
              onSubmit={handleUpdateMilestone}
              onCancel={() => setEditMilestone(null)}
            />
          )}
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation Dialog */}
      <Dialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Delete Milestone</DialogTitle>
            <DialogDescription>
              Are you sure you want to delete this milestone? This action cannot
              be undone. Tasks associated with this milestone will be unlinked,
              not deleted.
            </DialogDescription>
          </DialogHeader>
          <DialogFooter>
            <Button
              variant="outline"
              onClick={() => setDeleteDialogOpen(false)}
            >
              Cancel
            </Button>
            <Button variant="destructive" onClick={handleDeleteMilestone}>
              Delete
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
