import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { ConfigModule, ConfigService } from '@nestjs/config';
import * as Keycloak from 'keycloak-connect';
import * as session from 'express-session';
import { TypeOrmModule } from '@nestjs/typeorm';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TeamsModule } from './teams/teams.module';
import { configuration } from 'src/config';
import { CommonModule } from 'src/common/common.module';

@Module({
  imports: [
    CommonModule,
    ConfigModule.forRoot({
      isGlobal: true,
      load: [configuration],
    }),
    GraphQLModule.forRoot({
      autoSchemaFile: true,
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
    TeamsModule,
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get<string>('database.host'),
        port: +configService.get<number>('database.port'),
        username: configService.get<string>('database.username'),
        password: configService.get<string>('database.password'),
        database: configService.get<string>('database.database'),
        // entities: [__dirname + '/**/*.entity{.ts,.js}'],
        autoLoadEntities: true,
        logging: true,
        synchronize: false,
        schema: configService.get<string>('database.schema'),
      }),
      inject: [ConfigService],
    }),
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
