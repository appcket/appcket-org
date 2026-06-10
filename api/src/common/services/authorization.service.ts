import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig, AxiosResponse } from 'axios';
import { URLSearchParams } from 'url';
import { lastValueFrom, Observable } from 'rxjs';

import UserPermissionsResponse from 'src/common/models/responses/userPermissionsResponse';

@Injectable()
export class AuthorizationService {
  constructor(
    private httpService: HttpService,
    private configService: ConfigService,
  ) {}

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
    (permissions || []).forEach((perm: string) => {
      formData.append('permission', perm);
    });

    try {
      const response$ = this.httpService.post(
        this.configService.get('keycloak.tokenEndpointUrl') || '',
        formData,
        config,
      );

      const response = await lastValueFrom(response$);

      if (response.data.result) {
        return true;
      }
      return false;
    } catch (error) {
      console.log(error);
      return false;
    }
  }

  public getUserPermissions(token: string): Observable<AxiosResponse<UserPermissionsResponse[]>> {
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
      this.configService.get('keycloak.tokenEndpointUrl') || '',
      formData,
      config,
    );

    return response$;
  }

  public async getUserRole(token: string, userId: string): Promise<string | null> {
    const config: AxiosRequestConfig = {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        Authorization: `Bearer ${token}`,
      },
      responseType: 'json',
    };

    const response$ = this.httpService.get(
      (this.configService.get('keycloak.userRoleMappingsEndpointUrl') || '').replace(
        '__USER_ID__',
        userId,
      ),
      config,
    );

    const response = await lastValueFrom(response$);
    let role: string | null = null;

    if (response.data.realmMappings) {
      const roleMapping = response.data.realmMappings.find((roleMapping) => {
        return ['Manager', 'Captain', 'Teammate', 'Spectator'].includes(roleMapping.name);
      });

      if (roleMapping) {
        role = roleMapping.name;
      }
    }

    return role;
  }
}
