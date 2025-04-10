'use client';

import { usePathname, useRouter } from 'next/navigation';
import { APP_NAME, APP_VERSION } from '@/lib/constants';
import { 
  LayoutDashboard, 
  FolderKanban, 
  CheckSquare, 
  FileText, 
  MessageSquare, 
  BarChart, 
  Settings, 
  Users, 
  UserCircle 
} from 'lucide-react';

interface SidebarProps {
  isOpen: boolean;
}

export function Sidebar({ isOpen }: SidebarProps) {
  const router = useRouter();
  const pathname = usePathname();

  const navigation = [
    { name: 'Dashboard', href: '/dashboard', icon: LayoutDashboard },
    { name: 'Projects', href: '/projects', icon: FolderKanban },
    { name: 'My Tasks', href: '/tasks', icon: CheckSquare },
    { name: 'Documents', href: '/documents', icon: FileText },
    { name: 'Messages', href: '/messages', icon: MessageSquare },
    { name: 'Reports', href: '/reports', icon: BarChart },
    { name: 'Team', href: '/team', icon: Users },
    { name: 'Profile', href: '/profile', icon: UserCircle },
    { name: 'Settings', href: '/settings', icon: Settings },
  ];

  const isActive = (path: string) => {
    if (path === '/dashboard') {
      return pathname === path;
    }
    return pathname.startsWith(path);
  };

  return (
    <div
      className={`bg-white shadow-sm transition-all duration-300 ${
        isOpen ? 'w-64' : 'w-20'
      } flex flex-col`}
    >
      <div className="flex items-center justify-center h-16 border-b">
        <h1 className={`text-xl font-bold ${isOpen ? 'block' : 'hidden'}`}>
          {APP_NAME.split(' ')[0]}
        </h1>
        <span className={`text-2xl font-bold ${isOpen ? 'hidden' : 'block'}`}>
          B
        </span>
      </div>
      <nav className="flex-1 pt-4 pb-4">
        <ul className="space-y-1">
          {navigation.map((item) => (
            <li key={item.name}>
              <a
                href={item.href}
                onClick={(e) => {
                  e.preventDefault();
                  router.push(item.href);
                }}
                className={`flex items-center px-4 py-3 text-sm font-medium ${
                  isActive(item.href)
                    ? 'text-blue-600 bg-blue-50'
                    : 'text-gray-700 hover:text-blue-600 hover:bg-gray-50'
                } ${isOpen ? 'justify-start' : 'justify-center'}`}
              >
                <item.icon className={`h-5 w-5 ${isOpen ? 'mr-3' : ''}`} />
                {isOpen && <span>{item.name}</span>}
              </a>
            </li>
          ))}
        </ul>
      </nav>
      <div className="p-4 border-t">
        <div className={`text-xs text-gray-500 ${isOpen ? 'block' : 'hidden'}`}>
          <p>{APP_NAME}</p>
          <p>{APP_VERSION}</p>
        </div>
      </div>
    </div>
  );
} 