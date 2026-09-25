create table public.penalties (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null
    references public.users (id) on delete cascade,
  penalty_until timestamptz not null,
  reason text not null,
  created_at timestamptz not null default now(),
  constraint penalties_until_after_creation_check
    check (penalty_until > created_at)
);

create index penalties_user_until_idx
on public.penalties (user_id, penalty_until desc);

create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null
    references public.users (id) on delete cascade,
  type text not null,
  title text not null,
  body text not null,
  read_at timestamptz,
  created_at timestamptz not null default now(),
  constraint notifications_type_check
    check (btrim(type) <> '')
);

create index notifications_user_created_idx
on public.notifications (user_id, created_at desc);

create index notifications_user_unread_idx
on public.notifications (user_id, created_at desc)
where read_at is null;
