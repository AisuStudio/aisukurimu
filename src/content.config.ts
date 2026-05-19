import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

/* ---------------------------------------------------------------
   Content collections — Brand v2

   uebungen   — Übungen + Rätsel (Rätsel via subtype)
   werkzeuge  — Tool entries
   medien     — Films, books, podcasts, etc.
   --------------------------------------------------------------- */

const uebungen = defineCollection({
	loader: glob({ base: './src/content/uebungen', pattern: '**/*.{md,mdx}' }),
	schema: z.object({
		title: z.string(),
		description: z.string().max(200),
		category: z.enum(['hacking', 'coding', 'making', 'systemiker']),
		subtype: z.enum(['exercise', 'raetsel']).default('exercise'),
		level: z.number().int().min(1).max(3),
		duration: z.number().int().positive(),
		platforms: z.array(z.enum(['mac', 'windows', 'linux', 'browser'])).min(1),
		requiredTools: z.array(z.string()).optional(),
		tags: z.array(z.string()).default([]),
		image: z.string().optional(),
		date: z.coerce.date(),
		published: z.boolean().default(true),
		order: z.number().int().optional(),
	}),
});

const werkzeuge = defineCollection({
	loader: glob({ base: './src/content/werkzeuge', pattern: '**/*.{md,mdx}' }),
	schema: z.object({
		name: z.string(),
		description: z.string().max(280),
		level: z.enum(['basic', 'medium', 'advanced']),
		categories: z.array(z.enum(['coder', 'hacker', 'maker', 'systemiker'])),
		platforms: z.array(z.enum(['mac', 'windows', 'linux', 'browser'])).min(1),
		price: z.enum(['free', 'paid', 'school-license']),
		// `url` is optional in practice — system tools like Terminal/PowerShell
		// have no homepage. Foundation says required; we deviate.
		url: z.string().url().optional(),
		setupGuide: z.string().optional(),
		aisuTip: z.string().optional(),
		image: z.string().optional(),
		date: z.coerce.date(),
		published: z.boolean().default(true),
		order: z.number().int().optional(),
	}),
});

const medien = defineCollection({
	loader: glob({ base: './src/content/medien', pattern: '**/*.{md,mdx}' }),
	schema: z.object({
		title: z.string(),
		description: z.string().max(280),
		type: z.enum(['film', 'serie', 'buch', 'spiel', 'podcast', 'website', 'doku']),
		fskMin: z.number().int().min(0).optional(),
		genre: z.array(z.string()).default([]),
		url: z.string().url().optional(),
		image: z.string().optional(),
		aisuTip: z.string().optional(),
		date: z.coerce.date(),
		published: z.boolean().default(true),
	}),
});

export const collections = { uebungen, werkzeuge, medien };
