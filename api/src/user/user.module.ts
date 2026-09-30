import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { AuthorizationService } from '@/common/services/authorization.service';
import { UserService } from '@/user/services/user.service';
import { UserResolver } from '@/user/user.resolver';
import { User } from '@/user/user.entity';
import { OrganizationUser } from '@/organization/organizationUser.entity';

@Module({
  imports: [HttpModule, MikroOrmModule.forFeature([User, OrganizationUser])],
  providers: [AuthorizationService, UserResolver, UserService],
  exports: [UserService],
})
export class UserModule {}
