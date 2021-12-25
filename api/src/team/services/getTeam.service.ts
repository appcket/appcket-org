import { Injectable } from '@nestjs/common';

import { PrismaService } from 'src/common/services/prisma.service';
import { Team } from 'src/team/models/team.model';

@Injectable()
export class GetTeamService {
  constructor(private prismaService: PrismaService) {}

  public async getTeam(id: string): Promise<Team> {
    return this.prismaService.team.findFirst({
      where: { team_id: id, deleted_at: null },
      include: {
        team_user: {
          where: {
            deleted_at: null,
          },
        },
        organization: true,
      },
    });
  }
}
