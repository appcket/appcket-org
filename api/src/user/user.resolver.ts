import 'reflect-metadata';
import { Args, Context, Resolver, Query } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { User } from './models/user.model';
import { UserService } from 'src/user/services/user.service';

@Resolver(User)
export class UserResolver {
  constructor(@Inject(UserService) private userService: UserService) {}

  @Query((returns) => User)
  userInfo(@Context() ctx) {
    return this.userService.getUserInfo(ctx.req.kauth.grant.access_token.token);
  }

  // SearchUsers Query to return realm users based on criteria
  @Query((returns) => [User])
  searchUsers(@Args('organizationId') organizationId: string, @Context() ctx) {
    return this.userService.getUsers(organizationId, ctx.req.kauth.grant.access_token.token);
  }
}
