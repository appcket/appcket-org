import 'reflect-metadata';
import { Args, Context, Resolver, Query } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { User } from './user.entity';
import { UserService } from 'src/user/services/user.service';

@Resolver(User)
export class UserResolver {
  constructor(@Inject(UserService) private userService: UserService) {}

  @Query(() => User)
  async userInfo(@Context() ctx) {
    const user = await this.userService.getUserInfo(ctx.req.kauth.grant.access_token.token);
    return user;
  }

  @Query(() => [User])
  searchUsers(@Args('organizationId') organizationId: string) {
    return this.userService.getUsers(organizationId);
  }
}
