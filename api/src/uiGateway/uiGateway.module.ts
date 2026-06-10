import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { MikroOrmModule } from '@mikro-orm/nestjs';

import { AuthorizationService } from 'src/common/services/authorization.service';
import { UiGateway } from 'src/uiGateway/uiGateway.gateway';
import { UiGatewayController } from 'src/uiGateway/uiGateway.controller';
import { UserModule } from 'src/user/user.module';
import { UserService } from 'src/user/services/user.service';
import { User } from 'src/user/user.entity';

@Module({
  imports: [HttpModule, UserModule],
  providers: [AuthorizationService, UiGateway],
  controllers: [UiGatewayController],
  exports: [UiGateway],
})
export class UiGatewayModule {}
