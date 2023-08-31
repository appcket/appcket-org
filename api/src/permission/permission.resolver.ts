import 'reflect-metadata';
import { Args, Context, Resolver, Query } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';

@Resolver(Boolean)
export class PermissionResolver {
  constructor(@Inject(AuthorizationService) private authorizationService: AuthorizationService) {}

  @Query(() => Boolean)
  hasPermission(
    @Context() ctx,
    @Args({ name: 'permissions', type: () => [String] }) permissions: string[],
  ) {
    return this.authorizationService.checkPermission(
      permissions,
      ctx.req.kauth.grant.access_token.token,
    );
  }
}
