-- ContentIQ Supabase Schema
-- Run this in your Supabase project: SQL Editor → New query → paste → Run

create table if not exists workspaces (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  settings jsonb default '{}',
  created_at timestamptz default now()
);

-- Run this if workspaces table already exists:
-- alter table workspaces add column if not exists settings jsonb default '{}';

create table if not exists brand_docs (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid references workspaces(id) on delete cascade,
  raw_text text,
  business_name text,
  tagline text,
  audience text,
  tone text,
  content_pillars jsonb default '[]',
  pain_points jsonb default '[]',
  cta_goal text,
  buying_triggers text,
  competitors text,
  updated_at timestamptz default now()
);

create table if not exists posts (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid references workspaces(id) on delete cascade,
  topic text,
  platform text,
  format text default 'standard',
  stage text default 'standard',
  content jsonb,
  status text default 'draft',
  created_at timestamptz default now()
);

create table if not exists scanner_analyses (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid references workspaces(id) on delete cascade,
  raw_posts text,
  analysis jsonb,
  created_at timestamptz default now()
);

create table if not exists images (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid references workspaces(id) on delete cascade,
  storage_path text not null,
  public_url text not null,
  filename text,
  description text,
  tags jsonb default '[]',
  mood text,
  suitable_for text,
  created_at timestamptz default now()
);

-- Disable RLS for now (enable + add policies when you add auth)
alter table workspaces disable row level security;
alter table brand_docs disable row level security;
alter table posts disable row level security;
alter table scanner_analyses disable row level security;
alter table images disable row level security;
