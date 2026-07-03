import { supabase } from './supabase';

export const EMOJIS = [
  '🥤','🥪','🍕','🥦',
  '🕹️','🛷','🔮','🎉',
  '🧢','💎','🩴','👑',
  '🚁','🚧','⛺','🏖️',
];

export interface Player {
  id: string;
  nickname: string;
}

function encodeEmojis(emojis: string[]): string {
  return emojis.join('');
}

export function getLocalPlayer(): Player | null {
  try {
    const raw = localStorage.getItem('ak_player');
    return raw ? JSON.parse(raw) : null;
  } catch {
    return null;
  }
}

function saveLocalPlayer(p: Player) {
  localStorage.setItem('ak_player', JSON.stringify(p));
}

export async function loginOrRegister(
  nickname: string,
  emojis: string[],
): Promise<{ player: Player | null; error: string | null }> {
  const emojiCode = encodeEmojis(emojis);

  const { data: existing } = await supabase
    .from('players')
    .select('id, nickname, emoji_code')
    .eq('nickname', nickname)
    .maybeSingle();

  if (existing) {
    if (existing.emoji_code !== emojiCode) {
      return { player: null, error: 'Falscher Emoji-Code — versuch es nochmal!' };
    }
    const player = { id: existing.id, nickname: existing.nickname };
    saveLocalPlayer(player);
    return { player, error: null };
  }

  const { data: created, error } = await supabase
    .from('players')
    .insert({ nickname, emoji_code: emojiCode })
    .select('id, nickname')
    .single();

  if (error || !created) {
    return { player: null, error: 'Name schon vergeben — wähle einen anderen!' };
  }

  const player = { id: created.id, nickname: created.nickname };
  saveLocalPlayer(player);
  return { player, error: null };
}

export async function markComplete(exerciseSlug: string): Promise<void> {
  const player = getLocalPlayer();
  if (!player) return;

  // Optimistic local update
  try {
    const done: string[] = JSON.parse(localStorage.getItem('ak_done') ?? '[]');
    if (!done.includes(exerciseSlug)) {
      done.push(exerciseSlug);
      localStorage.setItem('ak_done', JSON.stringify(done));
    }
  } catch { /* ignore */ }

  await supabase
    .from('progress')
    .upsert(
      { player_id: player.id, exercise_slug: exerciseSlug },
      { onConflict: 'player_id,exercise_slug' },
    );
}

export function isLocallyComplete(exerciseSlug: string): boolean {
  try {
    const done: string[] = JSON.parse(localStorage.getItem('ak_done') ?? '[]');
    return done.includes(exerciseSlug);
  } catch {
    return false;
  }
}
