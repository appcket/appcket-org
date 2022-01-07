import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { lastValueFrom } from 'rxjs';

import { PrismaService } from 'src/common/services/prisma.service';
import { AuthorizationService } from 'src/common/services/authorization.service';
import { User } from 'src/user/models/user.model';

@Injectable()
export class UserService {
  constructor(
    private httpService: HttpService,
    private configService: ConfigService,
    private prismaService: PrismaService,
    private authorizationService: AuthorizationService,
  ) {}

  private formatUserModel(userResponse): User {
    return {
      user_id: userResponse.id,
      username: userResponse.username,
      email: userResponse.email,
      firstName: userResponse.firstName,
      lastName: userResponse.lastName,
      jobTitle:
        (userResponse.attributes &&
          userResponse?.attributes.jobTitle &&
          userResponse?.attributes.jobTitle[0]) ||
        '',
      teams: [],
      permissions: [],
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

      const userPermissionsResponse$ = await this.authorizationService.getUserPermissions(token);

      const response = await lastValueFrom(response$);
      const userPermissionsResponse = await lastValueFrom(userPermissionsResponse$);

      if (response.data) {
        let user: User = this.formatUserModel(response.data);

        user.permissions = userPermissionsResponse.data;

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

  // TODO: uses the keycloak REST admin api to return all users in a realm
  // better to query the user_entity table in the keycloak schema directly and get users by an array of userIds, https://github.com/prisma/prisma/issues/2443#issuecomment-630679118
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
