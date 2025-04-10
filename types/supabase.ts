export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      teams: {
        Row: {
          id: string
          name: string
          description: string | null
          created_by: string
          created_at: string
          updated_at: string
          avatar_url: string | null
        }
        Insert: {
          id?: string
          name: string
          description?: string | null
          created_by: string
          created_at?: string
          updated_at?: string
          avatar_url?: string | null
        }
        Update: {
          id?: string
          name?: string
          description?: string | null
          created_by?: string
          created_at?: string
          updated_at?: string
          avatar_url?: string | null
        }
      }
      team_members: {
        Row: {
          id: string
          team_id: string
          user_id: string
          role: 'owner' | 'admin' | 'member'
          joined_at: string
          created_at: string
        }
        Insert: {
          id?: string
          team_id: string
          user_id: string
          role?: 'owner' | 'admin' | 'member'
          joined_at?: string
          created_at?: string
        }
        Update: {
          id?: string
          team_id?: string
          user_id?: string
          role?: 'owner' | 'admin' | 'member'
          joined_at?: string
          created_at?: string
        }
      }
      project_teams: {
        Row: {
          id: string
          project_id: string
          team_id: string
          created_at: string
          created_by: string
        }
        Insert: {
          id?: string
          project_id: string
          team_id: string
          created_at?: string
          created_by: string
        }
        Update: {
          id?: string
          project_id?: string
          team_id?: string
          created_at?: string
          created_by?: string
        }
      }
      team_invitations: {
        Row: {
          id: string
          team_id: string
          email: string
          role: 'admin' | 'member'
          invited_by: string
          token: string
          expires_at: string
          created_at: string
        }
        Insert: {
          id?: string
          team_id: string
          email: string
          role: 'admin' | 'member'
          invited_by: string
          token?: string
          expires_at: string
          created_at?: string
        }
        Update: {
          id?: string
          team_id?: string
          email?: string
          role?: 'admin' | 'member'
          invited_by?: string
          token?: string
          expires_at?: string
          created_at?: string
        }
      }
      profiles: {
        Row: {
          id: string
          first_name: string | null
          last_name: string | null
          avatar_url: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id: string
          first_name?: string | null
          last_name?: string | null
          avatar_url?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          first_name?: string | null
          last_name?: string | null
          avatar_url?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      projects: {
        Row: {
          id: string
          name: string
          description: string | null
          status: 'Planning' | 'In Progress' | 'On Hold' | 'Completed' | 'Canceled'
          start_date: string
          end_date: string | null
          owner_id: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          description?: string | null
          status?: 'Planning' | 'In Progress' | 'On Hold' | 'Completed' | 'Canceled'
          start_date?: string
          end_date?: string | null
          owner_id: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          description?: string | null
          status?: 'Planning' | 'In Progress' | 'On Hold' | 'Completed' | 'Canceled'
          start_date?: string
          end_date?: string | null
          owner_id?: string
          created_at?: string
          updated_at?: string
        }
      }
      project_members: {
        Row: {
          id: string
          project_id: string
          user_id: string
          role: 'owner' | 'admin' | 'member'
          joined_at: string
          team_id: string | null
        }
        Insert: {
          id?: string
          project_id: string
          user_id: string
          role?: 'owner' | 'admin' | 'member'
          joined_at?: string
          team_id?: string | null
        }
        Update: {
          id?: string
          project_id?: string
          user_id?: string
          role?: 'owner' | 'admin' | 'member'
          team_id?: string | null
          joined_at?: string
        }
      }
      tasks: {
        Row: {
          id: string
          title: string
          description: string | null
          status: 'To Do' | 'In Progress' | 'Completed'
          priority: 'Low' | 'Medium' | 'High'
          due_date: string | null
          project_id: string
          assignee_id: string | null
          creator_id: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          title: string
          description?: string | null
          status?: 'To Do' | 'In Progress' | 'Completed'
          priority?: 'Low' | 'Medium' | 'High'
          due_date?: string | null
          project_id: string
          assignee_id?: string | null
          creator_id: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          title?: string
          description?: string | null
          status?: 'To Do' | 'In Progress' | 'Completed'
          priority?: 'Low' | 'Medium' | 'High'
          due_date?: string | null
          project_id?: string
          assignee_id?: string | null
          creator_id?: string
          created_at?: string
          updated_at?: string
        }
      }
      comments: {
        Row: {
          id: string
          content: string
          task_id: string
          user_id: string
          created_at: string
        }
        Insert: {
          id?: string
          content: string
          task_id: string
          user_id: string
          created_at?: string
        }
        Update: {
          id?: string
          content?: string
          task_id?: string
          user_id?: string
          created_at?: string
        }
      }
      files: {
        Row: {
          id: string
          name: string
          size: number
          mime_type: string
          storage_path: string
          project_id: string
          uploaded_by: string
          created_at: string
        }
        Insert: {
          id?: string
          name: string
          size: number
          mime_type: string
          storage_path: string
          project_id: string
          uploaded_by: string
          created_at?: string
        }
        Update: {
          id?: string
          name?: string
          size?: number
          mime_type?: string
          storage_path?: string
          project_id?: string
          uploaded_by?: string
          created_at?: string
        }
      }
      messages: {
        Row: {
          id: string
          content: string
          project_id: string
          user_id: string
          created_at: string
        }
        Insert: {
          id?: string
          content: string
          project_id: string
          user_id: string
          created_at?: string
        }
        Update: {
          id?: string
          content?: string
          project_id?: string
          user_id?: string
          created_at?: string
        }
      }
      activities: {
        Row: {
          id: string
          project_id: string
          user_id: string
          entity_type: string
          entity_id: string
          action: string
          details: Json | null
          created_at: string
        }
        Insert: {
          id?: string
          project_id: string
          user_id: string
          entity_type: string
          entity_id: string
          action: string
          details?: Json | null
          created_at?: string
        }
        Update: {
          id?: string
          project_id?: string
          user_id?: string
          entity_type?: string
          entity_id?: string
          action?: string
          details?: Json | null
          created_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      get_project_stats: {
        Args: {
          project_uuid: string
        }
        Returns: {
          total_tasks: number
          completed_tasks: number
          pending_tasks: number
          overdue_tasks: number
          progress: number
        }[]
      }
      log_activity: {
        Args: {
          project_uuid: string
          user_uuid: string
          entity_type_val: string
          entity_id_val: string
          action_val: string
          details_val?: Json | null
        }
        Returns: string
      }
      create_project_with_member: {
        Args: {
          p_name: string
          p_description: string
          p_status: string
          p_start_date: string
          p_end_date: string | null
          p_owner_id: string
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
  }
} 