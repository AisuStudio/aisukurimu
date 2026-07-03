-- aisukurimu: Progress Tracking
-- Run this in your Supabase SQL Editor

create table if not exists players (
  id          uuid primary key default gen_random_uuid(),
  nickname    text unique not null check (char_length(nickname) between 2 and 24),
  emoji_code  text not null,        -- sorted 4 emojis, e.g. "🍕🍔🌮🥤"
  created_at  timestamptz default now()
);

create table if not exists progress (
  id            uuid primary key default gen_random_uuid(),
  player_id     uuid references players(id) on delete cascade not null,
  exercise_slug text not null,
  completed_at  timestamptz default now(),
  unique(player_id, exercise_slug)
);

-- RLS
alter table players  enable row level security;
alter table progress enable row level security;

create policy "players: select all"  on players  for select using (true);
create policy "players: insert all"  on players  for insert with check (true);

create policy "progress: select all" on progress for select using (true);
create policy "progress: insert all" on progress for insert with check (true);

-- Leaderboard view
create or replace view leaderboard as
  select
    p.id,
    p.nickname,
    count(pr.id) as completed,
    count(pr.id) * 100 as score
  from players p
  left join progress pr on pr.player_id = p.id
  group by p.id, p.nickname
  order by score desc, p.created_at asc;
