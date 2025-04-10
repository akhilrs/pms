import { Metadata } from 'next';
import { APP_NAME } from '@/lib/constants';
import { LoginForm } from '@/components/auth/login-form';

export const metadata: Metadata = {
  title: `Login | ${APP_NAME}`,
  description: 'Login to your account',
};

export default function LoginPage() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50">
      <div className="w-full max-w-md">
        <div className="mb-8 text-center">
          <h1 className="text-3xl font-bold">{APP_NAME}</h1>
          <p className="mt-2 text-gray-600">Sign in to your account</p>
        </div>
        <LoginForm />
      </div>
    </div>
  );
} 