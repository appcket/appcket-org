import { readFileSync } from 'node:fs';
import { defineConfig } from '@mikro-orm/postgresql';
// import { SqlHighlighter } from '@mikro-orm/sql-highlighter';
import { TsMorphMetadataProvider } from '@mikro-orm/reflection';

// This is needed for connecting to a production db that requires SSL mode.
// if (process.env.DB_SSL_MODE === 'true') {
//   options['driverOptions'] = {
//     connection: {
//       ssl: {
//         caAppend: readFileSync('certs/ca-certificate.crt'),
//       },
//     },
//   };
// }

export default defineConfig({
  dbName: process.env.DB_NAME,
  schema: process.env.DB_SCHEMA,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_ADDR,
  port: parseInt(process.env.DB_PORT || '5432', 10),
  debug: ['info'],
  forceUtcTimezone: true,
  driverOptions: {
    sslMode: process.env.DB_SSL_MODE === 'true' ? true : false,
  },
  entities: ['dist/**/*.entity.js'],
  entitiesTs: ['src/**/*.entity.ts'],
  // highlighter: new SqlHighlighter(),
  metadataProvider: TsMorphMetadataProvider,
});
