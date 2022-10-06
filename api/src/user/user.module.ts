import { Module } from '@nestjs/common';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { UserService } from 'src/user/services/user.service';
import { CommonModule } from 'src/common/common.module';
import { UserResolver } from 'src/user/user.resolver';
import { User } from 'src/user/user.entity';

@Module({
  imports: [CommonModule, MikroOrmModule.forFeature({ entities: [User] })],
  providers: [AuthorizationService, UserService, UserResolver],
})
export class UserModule {}
