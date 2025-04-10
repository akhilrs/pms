import { Metadata } from 'next';
import { RegisterForm } from '@/components/auth/register-form';
import { APP_NAME } from '@/lib/constants';

export const metadata: Metadata = {
  title: `Register | ${APP_NAME}`,
  description: 'Create a new account',
};

export default function RegisterPage() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center py-12 px-4 sm:px-6 lg:px-8 bg-gray-50">
      <div className="w-full max-w-md">
        <div className="mb-8 text-center">
          <h1 className="text-3xl font-bold">{APP_NAME}</h1>
          <p className="mt-2 text-gray-600">Create a new account</p>
        </div>
        <RegisterForm />
      </div>
    </div>
  );
} 