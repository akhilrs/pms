import { randomUUID } from 'crypto';

// Types for our mock database
export interface User {
  id: string;
  email: string;
  password: string; // In a real app, this would be hashed
  created_at: string;
  updated_at: string;
}

export interface Profile {
  id: string; // Same as user ID
  first_name: string | null;
  last_name: string | null;
  avatar_url: string | null;
  created_at: string;
  updated_at: string;
}

export interface Session {
  id: string;
  user_id: string;
  access_token: string;
  refresh_token: string;
  expires_at: string;
  created_at: string;
}

// This is a mock of a real database
// In a production app, you would use a real database
// For this demo, we're keeping data in memory on the server

// Mock database storage - these will persist as long as the server is running
const mockDB = {
  users: [] as User[],
  profiles: [] as Profile[],
  sessions: [] as Session[]
};

// For development/testing only - add a default test user if none exists
const createDefaultTestUser = () => {
  const testEmail = 'test@example.com';
  
  if (!findUserByEmail(testEmail)) {
    console.log('Creating default test user');
    const user = createUser(testEmail, 'password123');
    createProfile(user.id, 'Test', 'User');
  }
};

// Initialize the database with a test user
createDefaultTestUser();

// Helper functions for working with the "database"
export function findUserByEmail(email: string): User | undefined {
  if (!email) return undefined;
  return mockDB.users.find(user => user.email.toLowerCase() === email.toLowerCase());
}

export function createUser(email: string, password: string): User {
  const existingUser = findUserByEmail(email);
  if (existingUser) {
    throw new Error('User already exists');
  }
  
  const now = new Date().toISOString();
  const user: User = {
    id: randomUUID(),
    email,
    password, // In a real app, this would be hashed
    created_at: now,
    updated_at: now
  };
  
  mockDB.users.push(user);
  
  // For debugging
  console.log(`User created: ${email}, Total users: ${mockDB.users.length}`);
  
  return user;
}

export function createProfile(userId: string, firstName: string | null, lastName: string | null): Profile {
  const now = new Date().toISOString();
  const profile: Profile = {
    id: userId,
    first_name: firstName,
    last_name: lastName,
    avatar_url: null,
    created_at: now,
    updated_at: now
  };
  
  mockDB.profiles.push(profile);
  return profile;
}

export function findProfileById(userId: string): Profile | undefined {
  return mockDB.profiles.find(profile => profile.id === userId);
}

export function authenticateUser(email: string, password: string): User | null {
  // For debugging
  console.log(`Authenticating user: ${email}, Total users in DB: ${mockDB.users.length}`);
  console.log('Current users:', mockDB.users.map(u => u.email).join(', ') || 'none');
  
  if (!email || !password) {
    console.log('Email or password is empty');
    return null;
  }
  
  const user = findUserByEmail(email);
  
  if (!user) {
    console.log(`User not found: ${email}`);
    return null;
  }
  
  if (user.password !== password) {
    console.log('Password does not match');
    return null;
  }
  
  console.log('User authenticated successfully');
  return user;
}

export function createSession(userId: string): Session {
  // Expire any existing sessions for this user
  mockDB.sessions = mockDB.sessions.filter(session => session.user_id !== userId);
  
  const now = new Date();
  const expiresAt = new Date(now);
  expiresAt.setDate(expiresAt.getDate() + 7); // Expire in 7 days
  
  const session: Session = {
    id: randomUUID(),
    user_id: userId,
    access_token: generateToken(32),
    refresh_token: generateToken(32),
    expires_at: expiresAt.toISOString(),
    created_at: now.toISOString()
  };
  
  mockDB.sessions.push(session);
  return session;
}

export function validateSession(accessToken: string): Session | null {
  const session = mockDB.sessions.find(s => s.access_token === accessToken);
  if (!session) {
    return null;
  }
  
  const now = new Date();
  const expiresAt = new Date(session.expires_at);
  
  if (now > expiresAt) {
    // Session has expired
    mockDB.sessions = mockDB.sessions.filter(s => s.id !== session.id);
    return null;
  }
  
  return session;
}

export function getUserById(userId: string): User | undefined {
  return mockDB.users.find(user => user.id === userId);
}

// DEBUG: Add function to view all users (for testing only)
export function getAllUsers(): Omit<User, 'password'>[] {
  return mockDB.users.map(user => {
    // Return user without password
    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword;
  });
}

// Helper function to generate random tokens
function generateToken(length: number): string {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let result = '';
  const charactersLength = characters.length;
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
} 