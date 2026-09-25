create table public.challenges (
  id uuid primary key default gen_random_uuid(),
  professor_id uuid not null
    references public.users (id) on delete restrict,
  title text not null,
  description text not null,
  required_members integer not null,
  duration_days integer not null,
  deliverable text not null,
  validation_criteria text not null,
  status text not null default 'PUBLISHED',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint challenges_required_members_check
    check (required_members > 0),
  constraint challenges_duration_days_check
    check (duration_days > 0),
  constraint challenges_status_check
    check (status in ('PUBLISHED', 'ARCHIVED')),
  constraint challenges_title_check
    check (btrim(title) <> '')
);

create trigger challenges_set_updated_at
before update on public.challenges
for each row
execute function public.set_updated_at();

create table public.groups (
  id uuid primary key default gen_random_uuid(),
  challenge_id uuid not null
    references public.challenges (id) on delete restrict,
  status text not null default 'WAITING',
  started_at timestamptz,
  deadline timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint groups_status_dates_check check (
    (
      status = 'WAITING'
      and started_at is null
      and deadline is null
    )
    or
    (
      status in ('ACTIVE', 'COMPLETED', 'FAILED')
      and started_at is not null
      and deadline is not null
      and deadline > started_at
    )
  )
);

create trigger groups_set_updated_at
before update on public.groups
for each row
execute function public.set_updated_at();

create table public.group_members (
  group_id uuid not null
    references public.groups (id) on delete restrict,
  user_id uuid not null
    references public.users (id) on delete restrict,
  joined_at timestamptz not null default now(),
  primary key (group_id, user_id)
);

create index challenges_professor_status_created_idx
on public.challenges (professor_id, status, created_at desc);

create index challenges_published_created_idx
on public.challenges (created_at desc)
where status = 'PUBLISHED';

create index groups_challenge_status_idx
on public.groups (challenge_id, status);

create index groups_active_deadline_idx
on public.groups (deadline)
where status = 'ACTIVE';

create index group_members_user_group_idx
on public.group_members (user_id, group_id);
