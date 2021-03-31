import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { GqlExecutionContext } from '@nestjs/graphql';
import { Reflector } from '@nestjs/core';

import { AuthorizationService } from 'src/common/services/authorization.service';

@Injectable()
export class PermissionsGuard implements CanActivate {
  constructor(private reflector: Reflector, private authorizationService: AuthorizationService) {}

  public async canActivate(context: ExecutionContext): Promise<boolean> {
    const permissions = this.reflector.get<string[]>('permissions', context.getHandler());
    if (!permissions) {
      return false;
    }

    const ctx = GqlExecutionContext.create(context).getContext();

    const hasPermission = await this.authorizationService.checkPermission(
      permissions,
      ctx.req.kauth.grant.access_token.token,
    );
    return hasPermission;
  }
}
