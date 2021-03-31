import { NestFactory } from '@nestjs/core';
import { ConfigService } from '@nestjs/config';
import * as fs from 'fs';

import { AppModule } from './app.module';

const httpsOptions = {
  cert: fs.readFileSync('certs/star.tls.crt'),
  key: fs.readFileSync('certs/star.tls.key'),
};

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    httpsOptions,
  });
  const config = app.get(ConfigService);
  app.enableCors({
    origin: config.get('appUrl'),
  });
  await app.listen(3000);
}
bootstrap();
