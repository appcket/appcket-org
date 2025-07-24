// @ts-check
import fs from "fs";
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

import react from '@astrojs/react';

// https://astro.build/config
export default defineConfig({
  vite: {
      plugins: [tailwindcss()],
      server: {
        https: {
          key: fs.readFileSync("certs/tls.key").toString(),
          cert: fs.readFileSync("certs/tls.crt").toString(),
        }
      }
	},
  server: {
    port: 3000,
    host: true,
  },

  integrations: [react()]
});