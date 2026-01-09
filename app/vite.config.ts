/// <reference types="vitest" />

import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tsconfigPaths from 'vite-tsconfig-paths';
import svgrPlugin from 'vite-plugin-svgr';
import tailwindcss from '@tailwindcss/vite';

// https://vitejs.dev/config/
// eslint-disable-next-line import/no-unused-modules
export default defineConfig({
  envDir: './',
  plugins: [react(), tsconfigPaths(), svgrPlugin(), tailwindcss()],
  optimizeDeps: {},
  server: {
    port: 3000,
    host: '0.0.0.0',
  },
  build: { sourcemap: true },
});
