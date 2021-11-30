import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { join } from 'path';
import { ConfigModule, ConfigService } from '@nestjs/config';
import * as Keycloak from 'keycloak-connect';
import * as session from 'express-session';

import { configuration } from 'src/config';
import { CommonModule } from 'src/common/common.module';
import { TeamModule } from './team/team.module';
import { UserModule } from './user/user.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({
  imports: [
    CommonModule,
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
    }),
    GraphQLModule.forRoot({
      autoSchemaFile: join(process.cwd(), 'src/schema.gql'),
      buildSchemaOptions: { dateScalarMode: 'timestamp' },
      context: ({ req }) => {
        return {
          user: {
            id: req.kauth.grant.access_token.content.sub,
            email: req.kauth.grant.access_token.content.email,
            username: req.kauth.grant.access_token.content.preferred_username,
            roles: req.kauth.grant.access_token.content.realm_access.roles,
          },
        };
      },
      installSubscriptionHandlers: true,
      path: '/',
    }),
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
      .forRoutes({ path: '*', method: RequestMethod.POST });
  }
}
