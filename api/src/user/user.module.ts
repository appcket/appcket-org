import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';
import { HttpModule } from '@nestjs/axios';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { UserService } from 'src/user/services/user.service';
import { UserResolver } from 'src/user/user.resolver';
import { User } from 'src/user/user.entity';
import { OrganizationUser } from 'src/organization/organizationUser.entity';

@Module({
  imports: [HttpModule, MikroOrmModule.forFeature([User, OrganizationUser])],
  providers: [AuthorizationService, UserResolver, UserService],
  exports: [UserService],
})
export class UserModule {}
