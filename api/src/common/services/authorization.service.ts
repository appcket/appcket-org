import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { URLSearchParams } from 'url';
import { lastValueFrom } from 'rxjs';
import * as _ from 'lodash';

import UserPermissionsResponse from 'src/common/models/responses/userPermissionsResponse';

@Injectable()
export class AuthorizationService {
  constructor(private httpService: HttpService, private configService: ConfigService) {}

  public async checkPermission(permissions: string[], token: string): Promise<boolean> {
    const config: AxiosRequestConfig = {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: `Bearer ${token}`,
      },
      responseType: 'json',
    };

    const formData = new URLSearchParams();
    formData.append('grant_type', 'urn:ietf:params:oauth:grant-type:uma-ticket');
    formData.append('audience', 'appcket_api');
    formData.append('response_mode', 'decision');
    _.each(permissions, (perm: string) => {
      formData.append('permission', perm);
    });

    try {
      const response$ = this.httpService.post(
        this.configService.get('keycloak.tokenEndpointUrl'),
        formData,
        config,
      );

      const response = await lastValueFrom(response$);

      if (response.data.result) {
        return true;
      }
    } catch (error) {
      console.log(error);
      return false;
    }
  }

  public async getUserPermissions(token: string) {
    const config: AxiosRequestConfig = {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: `Bearer ${token}`,
      },
      responseType: 'json',
    };

    const formData = new URLSearchParams();
    formData.append('grant_type', 'urn:ietf:params:oauth:grant-type:uma-ticket');
    formData.append('audience', 'appcket_api');
    formData.append('response_mode', 'permissions');

    const response$ = this.httpService.post(
      this.configService.get('keycloak.tokenEndpointUrl'),
      formData,
      config,
    );

    return response$;
  }
}
