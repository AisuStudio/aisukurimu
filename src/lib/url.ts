// Prepend the Astro `base` to a path so it works both at root (`/`) and under
// a subpath like `/aisukurimu/`. import.meta.env.BASE_URL is normalized by
// Astro to always end in `/`.
export function url(path: string): string {
  const base = import.meta.env.BASE_URL;
  if (!path) return base;
  const cleaned = path.startsWith('/') ? path.slice(1) : path;
  return base + cleaned;
}
