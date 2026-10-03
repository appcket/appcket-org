// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

import react from '@astrojs/react';

// https://astro.build/config
export default defineConfig({
  // Preserve inline text spacing across the Astro 7 whitespace-default change.
  compressHTML: true,
  vite: {
      plugins: [tailwindcss()],
	},
  server: {
    port: 3000,
    host: true,
    allowedHosts: true,
  },

  integrations: [react()]
});