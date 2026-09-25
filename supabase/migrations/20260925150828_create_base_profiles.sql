create extension if not exists pgcrypto with schema extensions;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

revoke execute on function public.set_updated_at()
from public, anon, authenticated;

create table public.users (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text,
  role text not null default 'STUDENT',
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  constraint users_role_check
    check (role in ('STUDENT', 'PROFESSOR', 'ADMIN'))
);

create trigger users_set_updated_at
before update on public.users
for each row
execute function public.set_updated_at();

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.users (id)
  values (new.id)
  on conflict (id) do nothing;

  return new;
end;
$$;

revoke execute on function public.handle_new_user()
from public, anon, authenticated;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
after insert on auth.users
for each row
execute function public.handle_new_user();
