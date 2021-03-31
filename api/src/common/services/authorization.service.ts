import { Injectable, HttpService } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AxiosRequestConfig } from 'axios';
import { URLSearchParams } from 'url';
import * as _ from 'lodash';

@Injectable()
export class AuthorizationService {
  constructor(private httpService: HttpService, private configService: ConfigService) { }

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
      const response = await this.httpService
        .post(this.configService.get('keycloak.tokenEndpointUrl'), formData, config)
        .toPromise();

      if (response.data.result) {
        return true;
      }
    } catch (error) {
      console.log(error);
      return false;
    }
  }
}
