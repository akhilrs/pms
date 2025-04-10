'use client';

import { PlusCircle } from 'lucide-react';
import Link from 'next/link';
import { TeamCard } from './team-card';
import { Button } from '@/components/ui/button';
import type { TeamWithDetails } from '@/lib/supabase/teams';

// Allow both TeamWithDetails and the simpler Team type from server
interface TeamListProps {
  teams: TeamWithDetails[] | any[];
  isLoading?: boolean;
}

export function TeamList({ teams, isLoading = false }: TeamListProps) {
  if (isLoading) {
    return (
      <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
        {Array.from({ length: 6 }).map((_, index) => (
          <div key={index} className="h-64 animate-pulse bg-gray-100 rounded-lg"></div>
        ))}
      </div>
    );
  }

  if (teams.length === 0) {
    return (
      <div className="text-center py-12 border rounded-lg bg-gray-50">
        <h3 className="text-lg font-medium text-gray-900 mb-2">No teams yet</h3>
        <p className="text-gray-500 mb-6">
          Create your first team to start organizing people working on projects.
        </p>
        <Button asChild>
          <Link href="/teams/new">
            <PlusCircle className="h-4 w-4 mr-2" />
            Create Team
          </Link>
        </Button>
      </div>
    );
  }

  return (
    <div className="grid gap-4 grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
      {teams.map((team) => (
        <TeamCard key={team.id} team={team} />
      ))}
    </div>
  );
}