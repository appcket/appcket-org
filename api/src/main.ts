import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Transport } from '@nestjs/microservices';
import { Logger } from 'nestjs-pino';

import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, {
    bufferLogs: true,
  });
  const config = app.get(ConfigService);

  // Connect Kafka microservice for event consumption
  app.connectMicroservice({
    transport: Transport.KAFKA,
    options: {
      client: {
        brokers: config.get<string[]>('redpanda.brokers') || [
          'redpanda-0.redpanda.redpanda.svc.cluster.local:9093',
        ],
      },
      consumer: {
        groupId: 'ui-gateway-consumer',
      },
    },
  });

  app.enableCors({
    origin: [config.get('appUrl')],
  });
  app.useGlobalPipes(new ValidationPipe());
  app.useLogger(app.get(Logger));
  app.enableShutdownHooks();

  // Start microservices (Kafka)
  await app.startAllMicroservices();

  await app.listen(3000);
}
bootstrap();
