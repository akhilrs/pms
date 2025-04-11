// components/tasks/TasksTab.tsx
import { useState } from "react";
import { Plus, Filter } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { TaskForm } from "@/components/tasks/TaskForm";
import { useToast } from "@/components/ui/use-toast";
import { createTask } from "@/lib/supabase/tasks";

type TasksTabProps = {
  projectId: string;
  milestones: any[];
  onTaskChange: () => void;
};

export function TasksTab({
  projectId,
  milestones,
  onTaskChange,
}: TasksTabProps) {
  const [formOpen, setFormOpen] = useState(false);
  const [selectedMilestone, setSelectedMilestone] = useState<
    string | undefined
  >();
  const { toast } = useToast();

  // Get all tasks from all milestones
  const allTasks = milestones.flatMap((milestone) =>
    milestone.tasks.map((task: any) => ({
      ...task,
      milestoneName: milestone.title,
      milestoneId: milestone.id,
    })),
  );

  // Filter tasks based on selected milestone
  const filteredTasks = selectedMilestone
    ? allTasks.filter((task: any) => task.milestoneId === selectedMilestone)
    : allTasks;

  const handleCreateTask = async (formData: any) => {
    try {
      const { error } = await createTask({
        ...formData,
        project_id: projectId,
        milestone_id: selectedMilestone || null,
      });
      if (error) throw error;

      toast({ title: "Success", description: "Task created successfully" });
      setFormOpen(false);
      onTaskChange();
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to create task",
        variant: "destructive",
      });
    }
  };

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <h2 className="font-medium">Project Tasks</h2>
        <div className="flex gap-2">
          <div className="flex items-center gap-2">
            <Filter size={16} />
            <Select
              value={selectedMilestone}
              onValueChange={setSelectedMilestone}
            >
              <SelectTrigger className="w-[180px]">
                <SelectValue placeholder="All Milestones" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="">All Milestones</SelectItem>
                {milestones.map((milestone) => (
                  <SelectItem key={milestone.id} value={milestone.id}>
                    {milestone.title}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <Button size="sm" onClick={() => setFormOpen(true)}>
            <Plus size={16} className="mr-2" /> Create Task
          </Button>
        </div>
      </div>

      {filteredTasks.length === 0 ? (
        <div className="text-center py-8 border rounded-md bg-gray-50">
          <p className="text-gray-500 mb-4">No tasks found</p>
          <Button onClick={() => setFormOpen(true)}>
            <Plus size={16} className="mr-2" /> Create Task
          </Button>
        </div>
      ) : (
        <div className="border rounded-md divide-y">
          {filteredTasks.map((task: any) => (
            <div
              key={task.id}
              className="p-3 flex items-start justify-between hover:bg-gray-50"
            >
              <div>
                <div className="flex items-center">
                  <div
                    className={`w-3 h-3 rounded-full mr-2 ${task.completed ? "bg-green-500" : "bg-blue-500"}`}
                  />
                  <h3
                    className={`font-medium ${task.completed ? "line-through text-gray-500" : ""}`}
                  >
                    {task.title}
                  </h3>
                </div>
                {task.description && (
                  <p className="text-sm text-gray-600 mt-1 ml-5">
                    {task.description}
                  </p>
                )}
                <div className="flex items-center mt-2 ml-5 text-xs text-gray-500">
                  <span className="mr-4">Milestone: {task.milestoneName}</span>
                  {task.due_date && (
                    <span>
                      Due: {new Date(task.due_date).toLocaleDateString()}
                    </span>
                  )}
                </div>
              </div>
              <div>
                <Badge
                  variant="outline"
                  className={
                    task.completed
                      ? "bg-green-100 text-green-800"
                      : "bg-blue-100 text-blue-800"
                  }
                >
                  {task.completed ? "Completed" : task.status || "To Do"}
                </Badge>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Create Task Dialog */}
      <Dialog
        open={formOpen}
        onOpenChange={(open) => {
          if (!open) setFormOpen(false);
        }}
      >
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Create Task</DialogTitle>
          </DialogHeader>
          <div className="mb-4">
            <label className="block text-sm font-medium mb-1">Milestone</label>
            <Select
              value={selectedMilestone}
              onValueChange={setSelectedMilestone}
            >
              <SelectTrigger>
                <SelectValue placeholder="No milestone" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="">No milestone</SelectItem>
                {milestones.map((milestone) => (
                  <SelectItem key={milestone.id} value={milestone.id}>
                    {milestone.title}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <TaskForm
            onSubmit={handleCreateTask}
            onCancel={() => setFormOpen(false)}
          />
        </DialogContent>
      </Dialog>
    </div>
  );
}
