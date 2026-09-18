-- Growth OS database schema
create extension if not exists pgcrypto;

create table if not exists public.goals (
  user_id uuid primary key references auth.users(id) on delete cascade,
  income numeric not null default 5000,
  proposals integer not null default 20,
  start numeric not null default 100,
  target numeric not null default 10000,
  score integer not null default 80,
  hours numeric not null default 25,
  updated_at timestamptz not null default now()
);

create table if not exists public.daily_checkins (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  hours numeric default 0,
  proposals integer default 0,
  conversations integer default 0,
  revenue numeric default 0,
  trading_pl numeric default 0,
  rules text default 'na',
  priority_done boolean default false,
  focus_done boolean default false,
  no_impulsive boolean default false,
  notes text,
  created_at timestamptz default now(),
  unique(user_id,date)
);

create table if not exists public.trades (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  trade_date date not null,
  pair text not null,
  direction text,
  entry numeric,
  exit numeric,
  position_size numeric default 0,
  leverage numeric default 1,
  risk numeric default 0,
  pl numeric default 0,
  strategy text,
  followed_plan boolean default true,
  notes text,
  created_at timestamptz default now()
);

create table if not exists public.clients (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  project text,
  value numeric default 0,
  mrr numeric default 0,
  source text,
  status text default 'Onboarded',
  created_at timestamptz default now()
);

alter table public.goals enable row level security;
alter table public.daily_checkins enable row level security;
alter table public.trades enable row level security;
alter table public.clients enable row level security;

drop policy if exists "goals own" on public.goals;
create policy "goals own" on public.goals for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
drop policy if exists "checkins own" on public.daily_checkins;
create policy "checkins own" on public.daily_checkins for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
drop policy if exists "trades own" on public.trades;
create policy "trades own" on public.trades for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
drop policy if exists "clients own" on public.clients;
create policy "clients own" on public.clients for all using (auth.uid()=user_id) with check (auth.uid()=user_id);