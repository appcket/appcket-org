import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { UserService } from 'src/common/services/user.service';
import { PrismaService } from 'src/prisma.service';
import { CommonModule } from 'src/common/common.module';
import { UserResolver } from './user.resolver';

@Module({
  imports: [CommonModule],
  providers: [AuthorizationService, UserService, PrismaService, UserResolver],
})
export class UserModule {}
