import fs from "fs";
import { defineConfig } from "astro/config";

import tailwind from "@astrojs/tailwind";
import sitemap from "@astrojs/sitemap";

// https://astro.build/config
export default defineConfig({
  server: {
    port: 3000,
    host: true,
  },
  vite: {
    server: {
      https: {
        key: fs.readFileSync("certs/tls.key").toString(),
        cert: fs.readFileSync("certs/tls.crt").toString(),
      },
    },
    ssr: {
      external: ["svgo"],
    },
  },
  integrations: [tailwind(), sitemap()],
});
