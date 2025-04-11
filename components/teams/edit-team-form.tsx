'use client';

import { TeamForm } from './team-form';
import { updateTeam } from '@/app/teams/actions';
import type { Team } from '@/lib/supabase/teams';

interface EditTeamFormProps {
  team: Team;
  userId: string;
  title?: string;
  description?: string;
}

export function EditTeamForm({ team, userId, title, description }: EditTeamFormProps) {
  const handleSubmit = async (formData: any) => {
    return updateTeam(team.id, formData);
  };

  return (
    <TeamForm
      team={team}
      userId={userId}
      onSubmit={handleSubmit}
      submitLabel="Save Changes"
      title={title || "Team Details"}
      description={description || "Update your team's information"}
    />
  );
}