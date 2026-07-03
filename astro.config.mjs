// @ts-check

import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
	site: 'https://lab.aisu.studio',
	base: '/',
	trailingSlash: 'always',
	integrations: [mdx(), sitemap()],
	markdown: {
		syntaxHighlight: false,
	},
});
