import { Module } from '@nestjs/common';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { CommonModule } from 'src/common/common.module';
import { PermissionResolver } from './permission.resolver';

@Module({
  imports: [CommonModule],
  providers: [AuthorizationService, PermissionResolver],
})
export class PermissionModule {}
