import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { lastValueFrom } from 'rxjs';

import { PrismaService } from 'src/prisma.service';
import { User } from 'src/user/user';

@Injectable()
export class UserService {
  constructor(
    private httpService: HttpService,
    private configService: ConfigService,
    private prismaService: PrismaService,
  ) {}

  private formatUserModel(userResponse): User {
    return {
      user_id: userResponse.id,
      username: userResponse.username,
      email: userResponse.email,
      firstName: userResponse.firstName,
      jobTitle: (userResponse.attributes && userResponse?.attributes.jobTitle[0]) || '',
      teams: [],
    };
  }

  public async getUserInfo(token: string): Promise<User> {
    const config: AxiosRequestConfig = {
      headers: {
        Accept: 'application/json',
        Authorization: `Bearer ${token}`,
      },
      responseType: 'json',
    };

    try {
      const response$ = await this.httpService.get(
        this.configService.get('keycloak.userAccountEndpointUrl'),
        config,
      );

      const response = await lastValueFrom(response$);

      if (response.data) {
        let user: User = this.formatUserModel(response.data);

        let userTeams = await this.prismaService.team_user.findMany({
          where: {
            deleted_at: null,
            user_id: response.data.id,
          },
          include: {
            team: true,
          },
        });

        if (userTeams.length > 0) {
          userTeams.forEach((userTeam) => {
            user.teams.push(userTeam.team);
          });
        }

        return user;
      }
    } catch (error) {
      console.log(error);
      return null;
    }
  }

  // TODO: uses the keycloak rest admin api to return all users in a realm
  // better to query the user_entity table in the keycloak database directly and get users by an array of userIds, https://github.com/prisma/prisma/issues/2443#issuecomment-630679118
  public async getUsers(token: string): Promise<User[]> {
    const config: AxiosRequestConfig = {
      headers: {
        Authorization: `Bearer ${token}`,
      },
      responseType: 'json',
    };

    try {
      const response$ = await this.httpService.get(
        this.configService.get('keycloak.adminEndpointUrl') + '/users',
        config,
      );

      const response = await lastValueFrom(response$);

      let users = [];

      if (response.data.length > 0) {
        response.data.forEach((accountsUser) => {
          let user: User = this.formatUserModel(accountsUser);
          users.push(user);
        });
      }

      return users;
    } catch (error) {
      console.log(error);
      return null;
    }
  }
}
