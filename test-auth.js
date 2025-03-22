// Simple script to test the auth service directly
const fetch = require('node-fetch');

// Configuration
const supabaseUrl = 'http://localhost:8000';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

// Test signup
async function testSignup() {
  console.log('Testing signup...');
  
  try {
    const response = await fetch(`${supabaseUrl}/auth/v1/signup`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': supabaseAnonKey,
        'Authorization': `Bearer ${supabaseAnonKey}`
      },
      body: JSON.stringify({
        email: 'test@example.com',
        password: 'test123456'
      })
    });
    
    console.log('Status:', response.status);
    console.log('Headers:', response.headers);
    
    const data = await response.text();
    try {
      console.log('Response:', JSON.parse(data));
    } catch (e) {
      console.log('Response (text):', data);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

// Test token endpoint
async function testToken() {
  console.log('\nTesting token endpoint...');
  
  try {
    const response = await fetch(`${supabaseUrl}/auth/v1/token?grant_type=password`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': supabaseAnonKey,
        'Authorization': `Bearer ${supabaseAnonKey}`
      },
      body: JSON.stringify({
        email: 'test@example.com',
        password: 'test123456'
      })
    });
    
    console.log('Status:', response.status);
    console.log('Headers:', response.headers);
    
    const data = await response.text();
    try {
      console.log('Response:', JSON.parse(data));
    } catch (e) {
      console.log('Response (text):', data);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

// Test settings endpoint
async function testSettings() {
  console.log('\nTesting settings endpoint...');
  
  try {
    const response = await fetch(`${supabaseUrl}/auth/v1/settings`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'apikey': supabaseAnonKey,
        'Authorization': `Bearer ${supabaseAnonKey}`
      }
    });
    
    console.log('Status:', response.status);
    console.log('Headers:', response.headers);
    
    const data = await response.text();
    try {
      console.log('Response:', JSON.parse(data));
    } catch (e) {
      console.log('Response (text):', data);
    }
  } catch (error) {
    console.error('Error:', error);
  }
}

// Run all tests
async function runTests() {
  await testSignup();
  await testToken();
  await testSettings();
}

runTests(); 