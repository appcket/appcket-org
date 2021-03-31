import { Module } from '@nestjs/common';
import { NestjsQueryTypeOrmModule } from '@nestjs-query/query-typeorm';
import { NestjsQueryGraphQLModule } from '@nestjs-query/query-graphql';

import { TeamEntity } from 'src/teams/team.entity';
import { TeamDto } from 'src/teams/team.dto';
import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { resources } from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import { PermissionsGuard } from 'src/common/guards/permissions.guard';
import { Permissions } from 'src/common/decorators/permissions.decorator';

@Module({
  imports: [
    CommonModule,
    NestjsQueryGraphQLModule.forFeature({
      imports: [NestjsQueryTypeOrmModule.forFeature([TeamEntity])],
      services: [AuthorizationService],
      resolvers: [
        {
          DTOClass: TeamDto,
          EntityClass: TeamEntity,
          read: {
            decorators: [Permissions(`${resources.Team}#${TeamPermission.read}`)],
            guards: [PermissionsGuard],
          },
        },
      ],
    }),
  ],
})
export class TeamsModule {}
