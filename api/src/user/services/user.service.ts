import { Injectable, Logger } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { lastValueFrom } from 'rxjs';
import { InjectRepository } from '@mikro-orm/nestjs';
import { EntityManager, EntityRepository } from '@mikro-orm/postgresql';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { User } from 'src/user/user.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

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

  public async getUserInfo(token: string): Promise<User | null> {
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

      const userAccountEndpointUrl = this.configService.get<string>(
        'keycloak.userAccountEndpointUrl',
      );
      if (!userAccountEndpointUrl) {
        throw new Error('Keycloak user account endpoint URL is not configured');
      }

      const response$ = await this.httpService.get(userAccountEndpointUrl, config);

      const userPermissionsResponse$ = await this.authorizationService.getUserPermissions(token);

      const response = await lastValueFrom(response$);
      const userPermissionsResponse = await lastValueFrom(userPermissionsResponse$);

      if (response.data) {
        const userRoleResponse = await this.authorizationService.getUserRole(
          token,
          response.data.id,
        );

        let dbUser: User | null = await this.userRepository.findOne(response.data.id, {
          populate: ['organizationUsers.organization', 'projectUsers.project', 'teamUsers.team'],
        });

        // 2. If user doesn't exist locally (first time login), create them in the appcket.user table. This is a cache table for the appcket app. The real user data belongs to the IDP: Keycloak.
        if (!dbUser) {
          dbUser = this.userRepository.create({
            id: response.data.id,
            email: email || response.data.email,
            firstName: given_name || response.data.firstName,
            lastName: family_name || response.data.lastName,
            username: preferred_username || response.data.username,
          } as any);
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

        await this.em.persist(dbUser).flush();

        dbUser.role = userRoleResponse ?? undefined;
        dbUser.permissions = userPermissionsResponse.data || [];

        return dbUser;
      }

      return null;
    } catch (error) {
      const errorStack = error instanceof Error ? error.stack : String(error);
      this.logger.error('Error fetching/syncing user info', errorStack);
      return null;
    }
  }

  public async getUser(userId: string): Promise<User> {
    const dbUser = await this.userRepository.findOneOrFail(
      { id: userId },
      {
        populate: ['organizationUsers.organization', 'projectUsers.project', 'teamUsers.team'],
      },
    );
    return dbUser;
  }

  public async getUsersByIds(userIds: string[]): Promise<User[]> {
    const dbUsers = await this.userRepository.find({ id: { $in: userIds } });
    return dbUsers;
  }

  public async getOrganizationUsers(organizationId: string): Promise<User[]> {
    this.logger.debug(`Searching users for organizationId: ${organizationId}`);

    try {
      const orgUsers = await this.em.find(
        OrganizationUser,
        { organization: organizationId },
        {
          populate: ['user'],
        },
      );

      this.logger.debug(`Raw join records found: ${orgUsers.length}`);

      const users = orgUsers.map((ou) => ou.user);

      if (users.length > 0) {
        this.logger.debug(
          `Sample user: ${users[0].id} - ${users[0].firstName} ${users[0].lastName}`,
        );
      }

      return users;
    } catch (error: any) {
      const errorMessage = error instanceof Error ? error.message : String(error);
      const errorStack = error instanceof Error ? error.stack : '';
      this.logger.error(`Error in getOrganizationUsers: ${errorMessage}`, errorStack);
      return [];
    }
  }
}
