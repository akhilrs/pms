'use client';

import { format } from "date-fns";
import Link from "next/link";
import { Edit, Trash2, Clock, Users, FolderKanban } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { TeamMembers, TeamProjects } from "@/components/teams";
import { type TeamWithDetails } from "@/lib/supabase/teams";
import { 
  addTeamMember,
  updateTeamMemberRole,
  removeTeamMember,
  assignTeamToProject,
  removeTeamFromProject,
} from "@/app/teams/actions";

interface TeamDetailClientProps {
  team: TeamWithDetails;
  userId: string;
  isOwner: boolean;
  isAdmin: boolean;
  userProjects: Array<{ id: string; name: string }>;
}

export function TeamDetailClient({
  team,
  userId,
  isOwner,
  isAdmin,
  userProjects,
}: TeamDetailClientProps) {
  // Format the creation date
  const formattedDate = format(new Date(team.created_at), "MMMM d, yyyy");

  // Define handler functions to avoid passing server actions directly
  const handleAddMember = async (userId: string, role: string) => {
    return addTeamMember(team.id, userId, role as 'admin' | 'member');
  };

  const handleUpdateMember = async (memberId: string, role: string) => {
    return updateTeamMemberRole(team.id, memberId, role as 'admin' | 'member');
  };

  const handleRemoveMember = async (memberId: string) => {
    return removeTeamMember(team.id, memberId);
  };

  const handleInviteMember = async (email: string, role: string) => {
    // TODO: Implement invitation system
    return { success: true };
  };

  const handleAssignProject = async (projectId: string) => {
    return assignTeamToProject(team.id, projectId);
  };

  const handleRemoveProject = async (projectId: string) => {
    return removeTeamFromProject(team.id, projectId);
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div className="flex items-center space-x-4">
          <Avatar className="h-16 w-16">
            <AvatarImage src={team.avatar_url || undefined} alt={team.name} />
            <AvatarFallback className="bg-blue-500 text-white text-lg">
              {team.name.substring(0, 2).toUpperCase()}
            </AvatarFallback>
          </Avatar>
          <div>
            <h1 className="text-3xl font-bold">{team.name}</h1>
            <p className="text-gray-500">Created on {formattedDate}</p>
          </div>
        </div>
        
        {isAdmin && (
          <div className="flex space-x-2">
            <Button variant="outline" asChild>
              <Link href={`/teams/${team.id}/edit`}>
                <Edit className="h-4 w-4 mr-2" />
                Edit Team
              </Link>
            </Button>
            {isOwner && (
              <Button variant="destructive" asChild>
                <Link href={`/teams/${team.id}/delete`}>
                  <Trash2 className="h-4 w-4 mr-2" />
                  Delete Team
                </Link>
              </Button>
            )}
          </div>
        )}
      </div>

      {team.description && (
        <Card>
          <CardContent className="pt-6">
            <p className="text-gray-700">{team.description}</p>
          </CardContent>
        </Card>
      )}

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium flex items-center">
              <Users className="h-4 w-4 mr-2 text-gray-500" />
              Team Members
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="font-semibold text-2xl">
              {team.members.length}
            </div>
            <p className="text-sm text-gray-500">
              {team.members.filter((m) => m.role === "owner").length} owners,{" "}
              {team.members.filter((m) => m.role === "admin").length} admins
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium flex items-center">
              <FolderKanban className="h-4 w-4 mr-2 text-gray-500" />
              Projects
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="font-semibold text-2xl">
              {team.projects.length}
            </div>
            <p className="text-sm text-gray-500">
              Assigned to this team
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium flex items-center">
              <Clock className="h-4 w-4 mr-2 text-gray-500" />
              Team Activity
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="font-semibold text-2xl">
              Recent
            </div>
            <p className="text-sm text-gray-500">
              Last updated {format(new Date(team.updated_at || team.created_at), "MMM d")}
            </p>
          </CardContent>
        </Card>
      </div>

      <Tabs defaultValue="members">
        <TabsList className="grid w-full grid-cols-2">
          <TabsTrigger value="members">Team Members</TabsTrigger>
          <TabsTrigger value="projects">Projects</TabsTrigger>
        </TabsList>
        
        <TabsContent value="members" className="mt-6">
          <TeamMembers 
            team={team}
            isOwner={isOwner}
            isAdmin={isAdmin}
            currentUserId={userId}
            onAddMember={handleAddMember}
            onUpdateMember={handleUpdateMember}
            onRemoveMember={handleRemoveMember}
            onInviteMember={handleInviteMember}
          />
        </TabsContent>
        
        <TabsContent value="projects" className="mt-6">
          <TeamProjects 
            team={team}
            canManage={isAdmin}
            userId={userId}
            availableProjects={userProjects}
            onAssignProject={handleAssignProject}
            onRemoveProject={handleRemoveProject}
          />
        </TabsContent>
      </Tabs>
    </div>
  );
}