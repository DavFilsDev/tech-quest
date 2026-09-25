alter table public.users enable row level security;
alter table public.challenges enable row level security;
alter table public.groups enable row level security;
alter table public.group_members enable row level security;
alter table public.penalties enable row level security;
alter table public.notifications enable row level security;

revoke all on table public.users from anon, authenticated;
revoke all on table public.challenges from anon, authenticated;
revoke all on table public.groups from anon, authenticated;
revoke all on table public.group_members from anon, authenticated;
revoke all on table public.penalties from anon, authenticated;
revoke all on table public.notifications from anon, authenticated;

grant select on table public.users to authenticated;
grant select on table public.notifications to authenticated;

create policy users_read_own
on public.users
for select
to authenticated
using ((select auth.uid()) = id);

create policy notifications_read_own
on public.notifications
for select
to authenticated
using ((select auth.uid()) = user_id);
