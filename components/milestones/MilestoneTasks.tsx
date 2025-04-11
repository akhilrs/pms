"use client";

import { useState } from "react";
import { Plus, CheckCircle, Circle, Edit, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useToast } from "@/components/ui/use-toast";
import {
  assignTaskToMilestone,
  getUnassignedTasks,
} from "@/lib/supabase/milestones";
import { MilestoneWithTasks } from "@/lib/supabase/milestones";
import { format } from "date-fns";

interface MilestoneTasksProps {
  projectId: string;
  milestone: MilestoneWithTasks;
  onTasksChange: () => void;
}

export function MilestoneTasks({
  projectId,
  milestone,
  onTasksChange,
}: MilestoneTasksProps) {
  const [addTaskDialogOpen, setAddTaskDialogOpen] = useState(false);
  const [unassignedTasks, setUnassignedTasks] = useState<any[]>([]);
  const [selectedTaskId, setSelectedTaskId] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const { toast } = useToast();

  const handleOpenAddTask = async () => {
    try {
      setLoading(true);
      const { data, error } = await getUnassignedTasks(projectId);

      if (error) throw error;
      setUnassignedTasks(data);
      setAddTaskDialogOpen(true);
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to load unassigned tasks",
        variant: "destructive",
      });
      console.error("Error loading unassigned tasks:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleAddTaskToMilestone = async () => {
    if (!selectedTaskId) return;

    try {
      setLoading(true);
      const { error } = await assignTaskToMilestone(
        selectedTaskId,
        milestone.id,
      );

      if (error) throw error;

      toast({
        title: "Success",
        description: "Task added to milestone",
      });

      setAddTaskDialogOpen(false);
      setSelectedTaskId(null);
      onTasksChange();
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to add task to milestone",
        variant: "destructive",
      });
      console.error("Error adding task to milestone:", error);
    } finally {
      setLoading(false);
    }
  };

  const handleRemoveTaskFromMilestone = async (taskId: string) => {
    try {
      setLoading(true);
      const { error } = await assignTaskToMilestone(taskId, null);

      if (error) throw error;

      toast({
        title: "Success",
        description: "Task removed from milestone",
      });

      onTasksChange();
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to remove task from milestone",
        variant: "destructive",
      });
      console.error("Error removing task from milestone:", error);
    } finally {
      setLoading(false);
    }
  };

  const getPriorityBadgeClass = (priority: string) => {
    switch (priority) {
      case "High":
        return "bg-red-50 text-red-700 border-red-300";
      case "Medium":
        return "bg-yellow-50 text-yellow-700 border-yellow-300";
      case "Low":
        return "bg-green-50 text-green-700 border-green-300";
      default:
        return "bg-gray-50 text-gray-700 border-gray-300";
    }
  };

  return (
    <div>
      <div className="flex justify-between mb-4">
        <h3 className="font-medium">Tasks</h3>
        <Button
          variant="outline"
          size="sm"
          onClick={handleOpenAddTask}
          disabled={loading}
        >
          <Plus className="h-4 w-4 mr-2" /> Add Existing Task
        </Button>
      </div>

      {milestone.tasks.length === 0 ? (
        <div className="text-center py-6 bg-white rounded-md border">
          <p className="text-gray-500 mb-4">No tasks in this milestone yet</p>
          <div className="flex justify-center gap-2">
            <Button
              variant="outline"
              size="sm"
              onClick={handleOpenAddTask}
              disabled={loading}
            >
              <Plus className="h-4 w-4 mr-2" /> Add Existing Task
            </Button>
            <Button size="sm" asChild>
              <a
                href={`/projects/${projectId}/tasks/new?milestone=${milestone.id}`}
              >
                <Plus className="h-4 w-4 mr-2" /> Create New Task
              </a>
            </Button>
          </div>
        </div>
      ) : (
        <div className="space-y-2">
          {milestone.tasks.map((task) => (
            <div
              key={task.id}
              className="flex items-center justify-between p-3 bg-white rounded-md border hover:bg-gray-50"
            >
              <div className="flex items-center">
                {task.status === "Completed" ? (
                  <CheckCircle className="h-5 w-5 text-green-500 mr-2 flex-shrink-0" />
                ) : (
                  <Circle className="h-5 w-5 text-gray-300 mr-2 flex-shrink-0" />
                )}
                <div>
                  <div className="font-medium">{task.title}</div>
                  {task.due_date && (
                    <div className="text-xs text-gray-500">
                      Due: {format(new Date(task.due_date), "MMM d, yyyy")}
                    </div>
                  )}
                </div>
              </div>

              <div className="flex items-center gap-2">
                <Badge
                  variant="outline"
                  className={getPriorityBadgeClass(task.priority)}
                >
                  {task.priority}
                </Badge>

                <Button variant="ghost" size="icon" asChild>
                  <a href={`/projects/${projectId}/tasks/${task.id}`}>
                    <Edit className="h-4 w-4" />
                  </a>
                </Button>

                <Button
                  variant="ghost"
                  size="icon"
                  className="text-red-500 hover:text-red-700"
                  onClick={() => handleRemoveTaskFromMilestone(task.id)}
                  disabled={loading}
                >
                  <Trash2 className="h-4 w-4" />
                </Button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Add Task Dialog */}
      <Dialog open={addTaskDialogOpen} onOpenChange={setAddTaskDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Add Task to Milestone</DialogTitle>
            <DialogDescription>
              Select an existing task to add to this milestone
            </DialogDescription>
          </DialogHeader>

          {unassignedTasks.length === 0 ? (
            <div className="text-center py-4">
              <p className="text-gray-500 mb-4">
                No unassigned tasks available
              </p>
              <Button asChild>
                <a
                  href={`/projects/${projectId}/tasks/new?milestone=${milestone.id}`}
                >
                  <Plus className="h-4 w-4 mr-2" /> Create New Task
                </a>
              </Button>
            </div>
          ) : (
            <>
              <Select onValueChange={(value) => setSelectedTaskId(value)}>
                <SelectTrigger>
                  <SelectValue placeholder="Select a task" />
                </SelectTrigger>
                <SelectContent>
                  {unassignedTasks.map((task) => (
                    <SelectItem key={task.id} value={task.id}>
                      {task.title}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>

              <DialogFooter>
                <Button
                  variant="outline"
                  onClick={() => setAddTaskDialogOpen(false)}
                >
                  Cancel
                </Button>
                <Button
                  onClick={handleAddTaskToMilestone}
                  disabled={!selectedTaskId || loading}
                >
                  {loading ? "Adding..." : "Add to Milestone"}
                </Button>
              </DialogFooter>
            </>
          )}
        </DialogContent>
      </Dialog>
    </div>
  );
}
