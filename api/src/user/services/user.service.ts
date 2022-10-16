import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { lastValueFrom } from 'rxjs';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityRepository } from '@mikro-orm/postgresql';

import { AuthorizationService } from 'src/common/services/authorization.service';
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
        const dbUser = await this.userRepository.findOne(response.data.id, {
          populate: ['organizations', 'projects', 'teams', 'attributes'],
        });

        dbUser.permissions = userPermissionsResponse.data;

        return dbUser;
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
        populate: ['projects', 'teams', 'attributes'],
      },
    );
    return dbUsers;
  }
}
