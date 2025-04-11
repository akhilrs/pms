'use client';

import { TeamForm } from './team-form';
import { createTeam } from '@/app/teams/actions';

interface NewTeamFormProps {
  userId: string;
  title?: string;
  description?: string;
}

export function NewTeamForm({ userId, title, description }: NewTeamFormProps) {
  return (
    <TeamForm
      userId={userId}
      onSubmit={createTeam}
      submitLabel="Create Team"
      title={title || "Team Details"}
      description={description || "Enter information about your new team"}
    />
  );
}