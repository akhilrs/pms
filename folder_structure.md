.
├── api
│   ├── auth
│   │   ├── debug
│   │   │   └── route.ts
│   │   ├── session
│   │   │   └── route.ts
│   │   ├── signin
│   │   │   └── route.ts
│   │   ├── signout
│   │   │   └── route.ts
│   │   ├── signup
│   │   │   └── route.ts
│   │   ├── test-signin
│   │   │   └── route.ts
│   │   ├── test-signup
│   │   │   └── route.ts
│   │   ├── test-urls
│   │   │   └── route.ts
│   │   └── users
│   │       └── route.ts
│   ├── projects
│   │   ├── [id]
│   │   │   ├── route.ts
│   │   │   └── route.ts~
│   │   ├── route.ts
│   │   └── route.ts~
│   └── supabase-test
│       └── route.ts
├── app
│   ├── actions
│   │   └── file-actions.ts
│   ├── api
│   │   ├── auth
│   │   │   ├── session
│   │   │   ├── signin
│   │   │   ├── signout
│   │   │   └── signup
│   │   ├── debug
│   │   │   ├── create-bucket
│   │   │   ├── create-profiles
│   │   │   ├── fix-avatars
│   │   │   └── profiles
│   │   ├── projects
│   │   │   ├── [id]
│   │   │   └── route.ts
│   │   └── teams
│   │       ├── [id]
│   │       └── route.ts
│   ├── auth
│   │   ├── callback
│   │   │   ├── route.ts
│   │   │   └── route.ts~
│   │   ├── login
│   │   │   └── page.tsx
│   │   └── register
│   │       └── page.tsx
│   ├── dashboard
│   │   ├── page.tsx
│   │   └── page.tsx~
│   ├── favicon.ico
│   ├── globals.css
│   ├── layout.tsx
│   ├── page.tsx
│   ├── profile
│   │   └── page.tsx
│   ├── projects
│   │   ├── [id]
│   │   │   ├── edit
│   │   │   ├── page.tsx
│   │   │   ├── page.tsx~
│   │   │   └── teams
│   │   ├── actions.ts
│   │   ├── actions.ts~
│   │   ├── new
│   │   │   └── page.tsx
│   │   ├── page.tsx
│   │   └── page.tsx~
│   └── teams
│       ├── [id]
│       │   ├── edit
│       │   └── page.tsx
│       ├── actions.ts
│       ├── actions.ts~
│       ├── new
│       │   └── page.tsx
│       └── page.tsx
├── CLAUDE.md
├── components
│   ├── auth
│   │   ├── auth-guard.tsx
│   │   ├── auth-guard.tsx~
│   │   ├── avatar-upload.tsx
│   │   ├── avatar-upload.tsx~
│   │   ├── fix-profiles.tsx
│   │   ├── login-form.tsx
│   │   ├── login-form.tsx~
│   │   ├── register-form.tsx
│   │   ├── register-form.tsx~
│   │   ├── SignupForm.tsx
│   │   └── update-profile-form.tsx
│   ├── common
│   │   ├── index.tsx
│   │   ├── index.tsx~
│   │   ├── layout.tsx
│   │   ├── layout.tsx~
│   │   ├── reload-button.tsx
│   │   └── sidebar.tsx
│   ├── files
│   │   ├── empty-files-state.tsx
│   │   ├── empty-files-state.tsx~
│   │   ├── file-list.tsx
│   │   ├── file-list.tsx~
│   │   ├── file-upload.tsx
│   │   ├── file-upload.tsx~
│   │   ├── index.ts
│   │   ├── project-files-wrapper.tsx
│   │   ├── project-files.tsx
│   │   └── project-files.tsx~
│   ├── layouts
│   │   └── dashboard-layout.tsx
│   ├── messages
│   │   ├── index.ts
│   │   ├── message-form.tsx
│   │   ├── message-item.tsx
│   │   ├── message-list.tsx
│   │   └── project-messages-wrapper.tsx
│   ├── milestones
│   │   ├── index.ts
│   │   ├── index.ts~
│   │   ├── milestone-form.tsx
│   │   ├── milestone-form.tsx~
│   │   ├── milestone-list.tsx
│   │   ├── milestone-list.tsx~
│   │   ├── milestone-tasks.tsx
│   │   ├── milestone-tasks.tsx~
│   │   ├── project-milestones-wrapper.tsx
│   │   └── project-milestones-wrapper.tsx~
│   ├── projects
│   │   ├── edit-project-form.tsx
│   │   ├── edit-project-form.tsx~
│   │   ├── index.ts
│   │   ├── new-project-form.tsx
│   │   ├── new-project-form.tsx~
│   │   ├── project-card.tsx
│   │   ├── project-delete-button.tsx
│   │   ├── project-form.tsx
│   │   ├── project-form.tsx~
│   │   ├── project-list.tsx
│   │   └── project-teams-management.tsx
│   ├── reports
│   ├── tasks
│   │   ├── TaskForm.tsx
│   │   ├── TaskForm.tsx~
│   │   ├── TaskList.tsx
│   │   ├── TaskList.tsx~
│   │   ├── TasksTab.tsx
│   │   └── TasksTab.tsx~
│   ├── teams
│   │   ├── edit-team-form.tsx
│   │   ├── index.ts
│   │   ├── new-team-form.tsx
│   │   ├── team-card.tsx
│   │   ├── team-detail-client.tsx
│   │   ├── team-form.tsx
│   │   ├── team-list.tsx
│   │   ├── team-members.tsx
│   │   └── team-projects.tsx
│   └── ui
│       ├── alert-dialog.tsx
│       ├── avatar.tsx
│       ├── badge.tsx
│       ├── button.tsx
│       ├── calendar.tsx
│       ├── card.tsx
│       ├── collapsible.tsx
│       ├── dialog.tsx
│       ├── dropdown-menu.tsx
│       ├── form.tsx
│       ├── input.tsx
│       ├── label.tsx
│       ├── popover.tsx
│       ├── progress.tsx
│       ├── select.tsx
│       ├── sonner.tsx
│       ├── table.tsx
│       ├── tabs.tsx
│       └── textarea.tsx
├── components.json
├── compose.yml
├── development.log
├── development.log~
├── docker-compose.yml
├── eslint.config.mjs
├── favicon.ico
├── folder_structure.md
├── knowledgebase.md
├── lib
│   ├── constants.ts
│   ├── mock-auth
│   │   └── db.ts
│   ├── supabase
│   │   ├── auth-helpers.ts
│   │   ├── auth-helpers.ts~
│   │   ├── auth.ts
│   │   ├── auth.ts~
│   │   ├── client.ts
│   │   ├── client.ts~
│   │   ├── files-adapter.ts
│   │   ├── files-adapter.ts~
│   │   ├── files.ts
│   │   ├── files.ts~
│   │   ├── messages-adapter.ts
│   │   ├── messages.ts
│   │   ├── milestones.ts
│   │   ├── milestones.ts~
│   │   ├── projects.ts
│   │   ├── projects.ts~
│   │   ├── server-auth.ts
│   │   ├── server-auth.ts~
│   │   └── teams.ts
│   ├── utils
│   │   └── date-utils.ts
│   └── utils.ts
├── middleware.ts
├── middleware.ts~
├── next-env.d.ts
├── next.config.ts
├── next.config.ts~
├── package-lock.json
├── package.json
├── postcss.config.mjs
├── project_plan.md
├── project_plan.md~
├── public
│   ├── file.svg
│   ├── globe.svg
│   ├── next.svg
│   ├── vercel.svg
│   └── window.svg
├── README.md
├── scripts
├── supabase
│   ├── compose.yml
│   ├── config.toml
│   ├── migrations.1
│   │   ├── 20250410_pms.sql
│   │   ├── 20250410_pms.sql~
│   │   ├── 20250411_create_teams.sql
│   │   ├── 20250411_milestones.sql
│   │   ├── 20250411_milestones.sql~
│   │   ├── 20250411_tasks_assignee_relation.sql
│   │   ├── 20250411_tasks_simplified.sql
│   │   ├── message.sql
│   │   ├── project_files.sql
│   │   └── project_files.sql~
│   ├── migrations.bak
│   │   └── 20250410_initial.sql
│   ├── migrations.old
│   │   ├── 20240322_create_storage_bucket.sql
│   │   ├── create_avatar_bucket.sql
│   │   ├── create_messages_table.sql
│   │   ├── create_profiles_for_existing_users.sql
│   │   ├── fix_avatar_bucket_policies.sql
│   │   ├── fix_rls_policies.sql
│   │   ├── README.md
│   │   └── recreate_database.sql
│   └── schema.png
├── test-auth.js
├── tsconfig.json
└── types
    ├── supabase.ts
    └── supabase.ts~

70 directories, 203 files
