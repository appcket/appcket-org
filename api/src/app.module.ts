import { ConfigModule, ConfigService } from '@nestjs/config';
import { MiddlewareConsumer, Module, RequestMethod, Logger } from '@nestjs/common';
import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { GraphQLModule } from '@nestjs/graphql';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { join } from 'path';
import * as Keycloak from 'keycloak-connect';
import * as session from 'express-session';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { LoggerModule } from 'nestjs-pino';
import * as caAppend from 'ca-append';
import { readFileSync } from 'fs';

import { configuration } from 'src/config';
import { CommonModule } from 'src/common/modules/common.module';
import { CorrelationContext } from 'src/common/services/correlation-context.service';
import { CorrelationMiddleware } from 'src/common/middleware/correlation.middleware';
import { ClickHouseModule } from 'src/common/modules/clickhouse.module';
import { EntityHistoryModule } from 'src/entityHistory/entityHistory.module';
import { OrganizationModule } from 'src/organization/organization.module';
import { PermissionModule } from 'src/permission/permission.module';
import { ProjectModule } from 'src/project/project.module';
import { TaskModule } from 'src/task/task.module';
import { TaskStatusTypeModule } from 'src/taskStatusType/taskStatusType.module';
import { TeamModule } from 'src/team/team.module';
import { UserModule } from 'src/user/user.module';
import { UiGatewayModule } from 'src/uiGateway/uiGateway.module';
import { AppController } from 'src/app.controller';
import { AppService } from 'src/app.service';

caAppend.monkeyPatch();

@Module({
  imports: [
    CommonModule,
    ClickHouseModule,
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
    }),
    GraphQLModule.forRoot<ApolloDriverConfig>({
      driver: ApolloDriver,
      autoSchemaFile: join(process.cwd(), 'src/schema.gql'),
      buildSchemaOptions: { dateScalarMode: 'timestamp' },
      context: ({ req }) => {
        return {
          correlationId: req.headers['x-correlation-id'],
          user: {
            id: req.kauth?.grant?.access_token?.content?.sub,
            firstName: req.kauth?.grant?.access_token?.content?.firstName,
            lastName: req.kauth?.grant?.access_token?.content?.lastName,
            email: req.kauth?.grant?.access_token?.content?.email,
            username: req.kauth?.grant?.access_token?.content?.preferred_username,
            roles: req.kauth?.grant?.access_token?.content?.realm_access?.roles,
          },
        };
      },
      // CRITICAL: Keep this FALSE.
      // Enabling GraphQL Subscriptions (installSubscriptionHandlers: true) creates a WebSocket server
      // that conflicts with the Socket.io Adapter used by UiGateway on the same port/path.
      // This conflict causes "Invalid frame header" errors for Socket.io clients.
      // We use Socket.io (via UiGateway) for all realtime events, not GraphQL Subscriptions.
      installSubscriptionHandlers: false,
      path: '/',
      formatError: (error) => {
        const logger = new Logger('GraphQL');
        logger.error(
          `GraphQL Error: ${error.message}`,
          error.extensions?.stacktrace,
          JSON.stringify(error.extensions),
        );
        return error;
      },
    }),
    LoggerModule.forRootAsync({
      imports: [CommonModule],
      inject: [CorrelationContext],
      useFactory: (context: CorrelationContext) => ({
        pinoHttp: {
          // don't log the authorization Bearer token
          redact: ['req.headers.authorization'],
          // Attach correlationId from our context to every log message
          customProps: () => ({
            correlationId: context.id,
          }),
        },
      }),
    }),
    MikroOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => {
        const options = {
          autoLoadEntities: true,
          dbName: configService.get('orm.dbName'),
          schema: configService.get('orm.schema'),
          driver: configService.get('orm.driver'),
          user: configService.get('orm.user'),
          password: configService.get('orm.password'),
          host: configService.get('orm.host'),
          port: configService.get('orm.port'),
          debug: configService.get('orm.debug'),
          forceUtcTimezone: configService.get('orm.forceUtcTimezone'),
        };

        if (configService.get('orm.sslMode') === true) {
          options['driverOptions'] = {
            connection: {
              ssl: {
                caAppend: readFileSync('certs/ca-certificate.crt'),
              },
            },
          };
        }

        return options;
      },
      inject: [ConfigService],
    }),
    ClientsModule.registerAsync([
      {
        imports: [ConfigModule],
        name: 'EVENT_SERVICE',
        useFactory: async (configService: ConfigService) => ({
          transport: Transport.KAFKA,
          options: {
            client: {
              brokers: configService.get<string[]>('redpanda.brokers') || [
                'redpanda-0.redpanda.redpanda.svc.cluster.local:9093',
              ],
            },
            consumer: {
              groupId: configService.get<string>('redpanda.groupId') ?? 'default-group',
            },
          },
        }),
        inject: [ConfigService],
      },
    ]),
    EntityHistoryModule,
    OrganizationModule,
    PermissionModule,
    ProjectModule,
    TaskModule,
    TaskStatusTypeModule,
    TeamModule,
    UserModule,
    UiGatewayModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {
  constructor(private configService: ConfigService) {}
  configure(consumer: MiddlewareConsumer) {
    const memoryStore = new session.MemoryStore();
    // initialize keycloak using configuration service
    const keycloak = new Keycloak({ store: memoryStore }, this.configService.get('keycloak'));

    consumer.apply(CorrelationMiddleware).forRoutes('*');

    consumer
      // @ts-ignore
      .apply(keycloak.middleware(), keycloak.protect()) // keycloak.protect() here will ensure any graphql request must include a valid token
      .forRoutes({ path: '/', method: RequestMethod.POST });
  }
}
