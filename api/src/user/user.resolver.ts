import 'reflect-metadata';
import { Args, Context, Resolver, Query } from '@nestjs/graphql';
import { Inject } from '@nestjs/common';

import { UserDto } from 'src/user/user.dto';
import { UserService } from 'src/user/services/user.service';

@Resolver(UserDto)
export class UserResolver {
  constructor(@Inject(UserService) private userService: UserService) {}

  @Query(() => UserDto)
  async userInfo(@Context() ctx) {
    const user = await this.userService.getUserInfo(ctx.req.kauth.grant.access_token.token);
    return user;
  }

  @Query(() => [UserDto])
  searchUsers(@Args('organizationId') organizationId: string) {
    return this.userService.getOrganizationUsers(organizationId);
  }
}
