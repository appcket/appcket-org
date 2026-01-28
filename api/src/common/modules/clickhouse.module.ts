import { Global, Module } from '@nestjs/common';
import { createClient } from '@clickhouse/client';
import { ConfigService } from '@nestjs/config';

export const CLICKHOUSE_CLIENT = 'CLICKHOUSE_CLIENT';

@Global()
@Module({
  providers: [
    {
      provide: CLICKHOUSE_CLIENT,
      useFactory: (configService: ConfigService) => {
        return createClient({
          url: configService.get<string>('clickhouse.url') || 'http://localhost:8123',
          username: configService.get<string>('clickhouse.user') || 'dbuser',
          password: configService.get<string>('clickhouse.password') || 'Ch@ng3To@StrongP@ssw0rd',
          database: configService.get<string>('clickhouse.db') || 'appcket',
        });
      },
      inject: [ConfigService],
    },
  ],
  exports: [CLICKHOUSE_CLIENT],
})
export class ClickHouseModule {}
