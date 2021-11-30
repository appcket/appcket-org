import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';

import { User } from 'src/user/user';

@Injectable()
export class UserService {
  constructor(private httpService: HttpService, private configService: ConfigService) {}

  public async getUserInfo(token: string): Promise<User> {
    const config: AxiosRequestConfig = {
      headers: {
        Accept: 'application/json',
        Authorization: `Bearer ${token}`,
      },
      responseType: 'json',
    };

    try {
      const response = await this.httpService
        .get(this.configService.get('keycloak.userAccountEndpointUrl'), config)
        .toPromise();

      if (response.data) {
        // format Keycloak user info data to User model
        const user: User = {
          userId: response.data.id,
          username: response.data.username,
          email: response.data.email,
          firstName: response.data.firstName,
          jobTitle: response.data.attributes.jobTitle ? response.data.attributes.jobTitle[0] : '',
        };
        return user;
      }
    } catch (error) {
      console.log(error);
      return null;
    }
  }
}
