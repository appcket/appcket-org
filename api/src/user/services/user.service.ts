import { Injectable, Logger } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { lastValueFrom } from 'rxjs';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityManager, EntityRepository } from '@mikro-orm/postgresql';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { User } from 'src/user/user.entity';

@Injectable()
export class UserService {
  private readonly logger = new Logger(UserService.name);

  constructor(
    private httpService: HttpService,
    private configService: ConfigService,
    private authorizationService: AuthorizationService,
    private readonly em: EntityManager,
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
      // 1. Decode token to get jobTitle and other claims
      const tokenPayload = JSON.parse(Buffer.from(token.split('.')[1], 'base64').toString());
      const { jobTitle, email, given_name, family_name, preferred_username } = tokenPayload;

      const response$ = await this.httpService.get(
        this.configService.get('keycloak.userAccountEndpointUrl'),
        config,
      );

      const userPermissionsResponse$ = await this.authorizationService.getUserPermissions(token);

      const response = await lastValueFrom(response$);
      const userPermissionsResponse = await lastValueFrom(userPermissionsResponse$);

      if (response.data) {
        const userRoleResponse = await this.authorizationService.getUserRole(
          token,
          response.data.id,
        );

        let dbUser: User = await this.userRepository.findOne(response.data.id, {
          populate: ['organizations', 'projects', 'teams'],
        });

        // 2. If user doesn't exist locally (first time login), create them
        if (!dbUser) {
          dbUser = this.userRepository.create({
            id: response.data.id,
            email: email || response.data.email,
            firstName: given_name || response.data.firstName,
            lastName: family_name || response.data.lastName,
            username: preferred_username || response.data.username,
          });
        }

        // 3. Sync attributes and profile data from token
        dbUser.attributes = {
          ...dbUser.attributes,
          jobTitle: jobTitle,
        };
        dbUser.email = email || dbUser.email;
        dbUser.firstName = given_name || dbUser.firstName;
        dbUser.lastName = family_name || dbUser.lastName;
        dbUser.lastSyncedAt = new Date();

        await this.em.persistAndFlush(dbUser);

        dbUser.permissions = userPermissionsResponse.data;
        dbUser.role = userRoleResponse;

        return dbUser;
      }
    } catch (error) {
      this.logger.error('Error fetching/syncing user info', error.stack);
      return null;
    }
  }

  public async getUser(userId: string): Promise<User> {
    const dbUser = await this.userRepository.findOneOrFail(
      { id: userId },
      {
        populate: ['organizations', 'projects', 'teams'],
      },
    );
    return dbUser;
  }

  public async getUsersByIds(userIds: string[]): Promise<User[]> {
    const dbUsers = await this.userRepository.find({ id: { $in: userIds } });
    return dbUsers;
  }

  public async getOrganizationUsers(organizationId: string): Promise<User[]> {
    const dbUsers = await this.userRepository.find(
      { organizations: { id: organizationId } },
      {
        populate: ['projects', 'teams'],
      },
    );
    return dbUsers;
  }
}
