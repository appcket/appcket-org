import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { lastValueFrom } from 'rxjs';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { UserModel } from 'src/user/user.model';
import { User } from 'src/user/user.entity';

@Injectable()
export class UserService {
  constructor(
    private httpService: HttpService,
    private configService: ConfigService,
    private authorizationService: AuthorizationService,
    @InjectRepository(User)
    private readonly userRepository: EntityRepository<User>,
  ) {}

  private formatUserModel(userResponse): UserModel {
    return {
      id: userResponse.id,
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
      projects: [],
      permissions: [],
      organizations: [],
    };
  }

  public async getUserInfo(token: string): Promise<UserModel> {
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
        let user: UserModel = this.formatUserModel(response.data);

        user.permissions = userPermissionsResponse.data;

        const dbUser = await this.userRepository.findOne(user.id, {
          populate: ['organizations', 'projects', 'teams'],
        });

        user.organizations = dbUser.organizations.toJSON();
        user.projects = dbUser.projects.toJSON();
        user.teams = dbUser.teams.toJSON();

        return user;
      }
    } catch (error) {
      console.log(error);
      return null;
    }
  }

  public async getUsers(organizationId: string, token: string): Promise<User[]> {
    const dbUsers = await this.userRepository.find(
      { organizations: { id: organizationId } },
      {
        populate: ['projects', 'teams'],
      },
    );
    return dbUsers;
  }
}
