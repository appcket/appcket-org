import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as fs from 'fs';

import { AppModule } from './app.module';

const httpsOptions = {
  cert: fs.readFileSync('certs/api.tls.crt'),
  key: fs.readFileSync('certs/api.tls.key'),
};

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    httpsOptions,
  });
  const config = app.get(ConfigService);
  app.enableCors({
    origin: config.get('appUrl'),
  });
  app.useGlobalPipes(new ValidationPipe());
  await app.listen(3000);
}
bootstrap();
