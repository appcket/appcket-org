import 'reflect-metadata';
import { Context, Resolver, Query } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { User } from './user';
import { UserService } from 'src/common/services/user.service';

@Resolver(User)
export class UserResolver {
  constructor(@Inject(UserService) private userService: UserService) {}

  @Query((returns) => User)
  userInfo(@Context() ctx) {
    return this.userService.getUserInfo(ctx.req.kauth.grant.access_token.token);
  }
}
