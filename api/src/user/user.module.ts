import { Module } from '@nestjs/common';

import { UserService } from 'src/common/services/user.service';
import { PrismaService } from 'src/prisma.service';
import { CommonModule } from 'src/common/common.module';
import { UserResolver } from './user.resolver';

@Module({
  imports: [CommonModule],
  providers: [UserService, PrismaService, UserResolver],
})
export class UserModule {}
