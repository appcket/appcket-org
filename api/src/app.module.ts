import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { ApolloDriver, ApolloDriverConfig } from '@nestjs/apollo';
import { GraphQLModule } from '@nestjs/graphql';
import { join } from 'path';
import { ConfigModule, ConfigService } from '@nestjs/config';
import * as Keycloak from 'keycloak-connect';
import * as session from 'express-session';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { LoggerModule } from 'nestjs-pino';
import * as caAppend from 'ca-append';
import { readFileSync } from 'fs';

import { configuration } from 'src/config';
import { CommonModule } from 'src/common/common.module';
import { EntityHistoryModule } from 'src/entityHistory/entityHistory.module';
import { OrganizationModule } from './organization/organization.module';
import { PermissionModule } from './permission/permission.module';
import { ProjectModule } from './project/project.module';
import { TaskModule } from './task/task.module';
import { TaskStatusTypeModule } from './taskStatusType/taskStatusType.module';
import { TeamModule } from './team/team.module';
import { UserModule } from './user/user.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';

caAppend.monkeyPatch();

@Module({
  imports: [
    CommonModule,
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
          user: {
            id: req.kauth.grant.access_token.content.sub,
            firstName: req.kauth.grant.access_token.content.firstName,
            lastName: req.kauth.grant.access_token.content.lastName,
            email: req.kauth.grant.access_token.content.email,
            username: req.kauth.grant.access_token.content.preferred_username,
            roles: req.kauth.grant.access_token.content.realm_access.roles,
          },
        };
      },
      installSubscriptionHandlers: true,
      path: '/',
    }),
    LoggerModule.forRoot({
      pinoHttp: {
        // don't log the authorization Bearer token
        redact: ['req.headers.authorization'],
      },
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
    EntityHistoryModule,
    OrganizationModule,
    PermissionModule,
    ProjectModule,
    TaskModule,
    TaskStatusTypeModule,
    TeamModule,
    UserModule,
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

    consumer
      // @ts-ignore
      .apply(keycloak.middleware(), keycloak.protect()) // keycloak.protect() here will ensure any graphql request must include a valid token
      .forRoutes({ path: '/', method: RequestMethod.POST });
  }
}
