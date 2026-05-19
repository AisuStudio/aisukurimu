import { defineCollection } from 'astro:content';
import { glob } from 'astro/loaders';
import { z } from 'astro/zod';

/* ---------------------------------------------------------------
   Content collections — aisukurimu

   exercises — Übungen/Aufgaben (German MD, English slug filenames)
   raetsel   — interactive multi-question puzzles
   tools     — werkzeugkasten entries (one MD per tool)
   --------------------------------------------------------------- */

const exercises = defineCollection({
	loader: glob({ base: './src/content/exercises', pattern: '**/*.{md,mdx}' }),
	schema: z.object({
		title: z.string(),
		slug: z.string().optional(),
		category: z.string(),
		subcategory: z.string().optional(),
		difficulty: z.number(),
		ageMin: z.number(),
		duration: z.number(),
		session: z.number().optional(),
		platforms: z.array(z.string()).default(['mac']),
		requiredTools: z.array(z.string()).default([]),
		tags: z.array(z.string()).default([]),
		date: z.coerce.date(),
		language: z.string().default('de'),
		description: z.string().optional(),
	}),
});

const raetsel = defineCollection({
	loader: glob({ base: './src/content/raetsel', pattern: '**/*.{md,mdx}' }),
	schema: z.object({
		title: z.string(),
		slug: z.string().optional(),
		category: z.string().optional(),
		subcategory: z.string().optional(),
		difficulty: z.string(),
		puzzles: z.number(),
		duration: z.number(),
		ageMin: z.number(),
		tags: z.array(z.string()).default([]),
		date: z.coerce.date(),
		language: z.string().default('de'),
		description: z.string().optional(),
	}),
});

const tools = defineCollection({
	loader: glob({ base: './src/content/tools', pattern: '**/*.{md,mdx}' }),
	schema: z.object({
		name: z.string(),
		tagline: z.string().optional(),
		level: z.enum(['basic', 'medium', 'advanced']),
		categories: z.array(z.string()),
		platforms: z.array(z.string()),
		price: z.enum(['free', 'paid', 'school-license']),
		url: z.string().url().optional(),
		aisuTip: z.string().optional(),
		order: z.number().default(99),
	}),
});

export const collections = { exercises, raetsel, tools };
