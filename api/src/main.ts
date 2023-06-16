import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as fs from 'fs';
import { Logger } from 'nestjs-pino';

import { AppModule } from './app.module';

const httpsOptions = {
  cert: fs.readFileSync('certs/api.tls.crt'),
  key: fs.readFileSync('certs/api.tls.key'),
};

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    httpsOptions,
    bufferLogs: true,
  });
  const config = app.get(ConfigService);
  app.enableCors({
    origin: config.get('appUrl'),
  });
  app.useGlobalPipes(new ValidationPipe());
  app.useLogger(app.get(Logger));
  app.enableShutdownHooks();
  await app.listen(3000);
}
bootstrap();
