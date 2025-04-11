import { useState } from "react";
import { Plus, Edit, Trash2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { TaskForm } from "@/components/tasks/TaskForm";
import { useToast } from "@/components/ui/use-toast";
import { createTask, updateTask, deleteTask } from "@/lib/supabase/tasks";

type Task = {
  id: string;
  title: string;
  description: string | null;
  status: string;
  due_date: string | null;
  completed: boolean;
};

type TaskListProps = {
  projectId: string;
  milestoneId: string;
  tasks: Task[];
  onTaskChange: () => void;
};

export function TaskList({
  projectId,
  milestoneId,
  tasks,
  onTaskChange,
}: TaskListProps) {
  const [formOpen, setFormOpen] = useState(false);
  const [editingTask, setEditingTask] = useState<Task | null>(null);
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const { toast } = useToast();

  const handleCreate = async (formData: any) => {
    try {
      const { error } = await createTask({
        ...formData,
        project_id: projectId,
        milestone_id: milestoneId,
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

  const handleUpdate = async (formData: any) => {
    if (!editingTask) return;

    try {
      const { error } = await updateTask(editingTask.id, formData);
      if (error) throw error;

      toast({ title: "Success", description: "Task updated successfully" });
      setEditingTask(null);
      onTaskChange();
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to update task",
        variant: "destructive",
      });
    }
  };

  const handleDelete = async (id: string) => {
    try {
      const { error } = await deleteTask(id);
      if (error) throw error;

      toast({ title: "Success", description: "Task deleted successfully" });
      onTaskChange();
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to delete task",
        variant: "destructive",
      });
    } finally {
      setDeletingId(null);
    }
  };

  const toggleTaskCompletion = async (task: Task) => {
    try {
      const { error } = await updateTask(task.id, {
        completed: !task.completed,
      });
      if (error) throw error;

      onTaskChange();
    } catch (error) {
      toast({
        title: "Error",
        description: "Failed to update task status",
        variant: "destructive",
      });
    }
  };

  return (
    <div>
      <div className="flex justify-between mb-2">
        <h4 className="text-sm font-medium">Tasks</h4>
        <Button
          variant="link"
          size="sm"
          className="h-auto p-0"
          onClick={() => setFormOpen(true)}
        >
          <Plus size={14} className="mr-1" /> Add Task
        </Button>
      </div>

      {tasks.length === 0 ? (
        <p className="text-sm text-gray-500 py-4 text-center">
          No tasks added to this milestone yet
        </p>
      ) : (
        <div className="space-y-2">
          {tasks.map((task) => (
            <div
              key={task.id}
              className="flex items-center justify-between p-2 hover:bg-gray-100 rounded"
            >
              <div className="flex items-center">
                <Checkbox
                  checked={task.completed}
                  id={`task-${task.id}`}
                  className="mr-2"
                  onCheckedChange={() => toggleTaskCompletion(task)}
                />
                <label
                  htmlFor={`task-${task.id}`}
                  className={task.completed ? "line-through text-gray-500" : ""}
                >
                  {task.title}
                </label>
              </div>
              <div className="flex space-x-2">
                <Button
                  variant="ghost"
                  size="sm"
                  className="h-8 w-8 p-0"
                  onClick={() => setEditingTask(task)}
                >
                  <Edit size={16} />
                </Button>
                <Button
                  variant="ghost"
                  size="sm"
                  className="h-8 w-8 p-0 text-red-500 hover:text-red-600"
                  onClick={() => setDeletingId(task.id)}
                >
                  <Trash2 size={16} />
                </Button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Create/Edit Task Dialog */}
      <Dialog
        open={formOpen || editingTask !== null}
        onOpenChange={(open) => {
          if (!open) {
            setFormOpen(false);
            setEditingTask(null);
          }
        }}
      >
        <DialogContent>
          <DialogHeader>
            <DialogTitle>
              {editingTask ? "Edit Task" : "Create Task"}
            </DialogTitle>
          </DialogHeader>
          <TaskForm
            initialData={editingTask || undefined}
            onSubmit={editingTask ? handleUpdate : handleCreate}
            onCancel={() => {
              setFormOpen(false);
              setEditingTask(null);
            }}
          />
        </DialogContent>
      </Dialog>

      {/* Delete Confirmation Dialog */}
      <Dialog
        open={deletingId !== null}
        onOpenChange={(open) => {
          if (!open) setDeletingId(null);
        }}
      >
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Confirm Deletion</DialogTitle>
          </DialogHeader>
          <p>Are you sure you want to delete this task?</p>
          <div className="flex justify-end space-x-2 mt-4">
            <Button variant="outline" onClick={() => setDeletingId(null)}>
              Cancel
            </Button>
            <Button
              variant="destructive"
              onClick={() => deletingId && handleDelete(deletingId)}
            >
              Delete
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
