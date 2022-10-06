import 'reflect-metadata';
import { Args, Context, Resolver, Query } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { UserModel } from './user.model';
import { UserService } from 'src/user/services/user.service';

@Resolver(UserModel)
export class UserResolver {
  constructor(@Inject(UserService) private userService: UserService) {}

  @Query((returns) => UserModel)
  userInfo(@Context() ctx) {
    return this.userService.getUserInfo(ctx.req.kauth.grant.access_token.token);
  }

  @Query((returns) => [UserModel])
  searchUsers(@Args('organizationId') organizationId: string, @Context() ctx) {
    return this.userService.getUsers(organizationId, ctx.req.kauth.grant.access_token.token);
  }
}
