import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

/**
 * Format a Date object to a string in ISO format for Supabase
 * This ensures dates are properly saved in Supabase
 */
export function formatDateForSupabase(date: Date | null | undefined): string | null {
  if (!date) return null;
  return date.toISOString();
}
