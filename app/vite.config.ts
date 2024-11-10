/// <reference types="vitest" />

import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tsconfigPaths from 'vite-tsconfig-paths';
import svgrPlugin from 'vite-plugin-svgr';
import fs from 'fs';

// https://vitejs.dev/config/
// eslint-disable-next-line import/no-unused-modules
export default defineConfig({
  envDir: './',
  plugins: [react(), tsconfigPaths(), svgrPlugin()],
  optimizeDeps: {},
  server: {
    port: 3000,
    host: '0.0.0.0',
    https: {
      key: fs.readFileSync('certs/app.tls.key'),
      cert: fs.readFileSync('certs/app.tls.crt'),
    },
  },
  build: {
    sourcemap: true,
  },
  test: {
    environment: 'happy-dom',
    globals: true,
  },
});
