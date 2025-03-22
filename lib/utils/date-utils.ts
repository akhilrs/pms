import { format, formatDistance, parseISO, isValid, isAfter, isBefore } from 'date-fns';

export function formatDate(date: string | Date, formatString: string = 'MMM d, yyyy'): string {
  if (!date) return '';
  
  const dateObj = typeof date === 'string' ? parseISO(date) : date;
  
  if (!isValid(dateObj)) {
    return 'Invalid date';
  }
  
  return format(dateObj, formatString);
}

export function formatRelativeDate(date: string | Date): string {
  if (!date) return '';
  
  const dateObj = typeof date === 'string' ? parseISO(date) : date;
  
  if (!isValid(dateObj)) {
    return 'Invalid date';
  }
  
  return formatDistance(dateObj, new Date(), { addSuffix: true });
}

export function isOverdue(date: string | Date): boolean {
  if (!date) return false;
  
  const dateObj = typeof date === 'string' ? parseISO(date) : date;
  
  if (!isValid(dateObj)) {
    return false;
  }
  
  return isBefore(dateObj, new Date());
}

export function isUpcoming(date: string | Date, daysThreshold: number = 7): boolean {
  if (!date) return false;
  
  const dateObj = typeof date === 'string' ? parseISO(date) : date;
  
  if (!isValid(dateObj)) {
    return false;
  }
  
  const now = new Date();
  const thresholdDate = new Date();
  thresholdDate.setDate(now.getDate() + daysThreshold);
  
  return isAfter(dateObj, now) && isBefore(dateObj, thresholdDate);
}

export function getDaysRemaining(date: string | Date): number {
  if (!date) return 0;
  
  const dateObj = typeof date === 'string' ? parseISO(date) : date;
  
  if (!isValid(dateObj)) {
    return 0;
  }
  
  const now = new Date();
  const diffTime = dateObj.getTime() - now.getTime();
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
  
  return diffDays > 0 ? diffDays : 0;
} 