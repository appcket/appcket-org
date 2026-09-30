import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from '@/common/services/authorization.service';
import { UiGateway } from '@/uiGateway/uiGateway.gateway';
import { UiGatewayController } from '@/uiGateway/uiGateway.controller';
import { UserModule } from '@/user/user.module';
import { UserService } from '@/user/services/user.service';
import { User } from '@/user/user.entity';

@Module({
  imports: [HttpModule, UserModule],
  providers: [AuthorizationService, UiGateway],
  controllers: [UiGatewayController],
  exports: [UiGateway],
})
export class UiGatewayModule {}
