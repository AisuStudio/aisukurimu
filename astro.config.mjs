// @ts-check

import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
	site: 'https://lab.aisu.studio',
	base: '/',
	trailingSlash: 'always',
	// /atoll/ ist eine bewusst unverlinkte Seite (nur per direkter URL teilbar)
	// und wird deshalb aus der Sitemap ausgeschlossen.
	integrations: [mdx(), sitemap({ filter: (page) => !page.includes('/atoll') })],
	markdown: {
		syntaxHighlight: false,
	},
});
