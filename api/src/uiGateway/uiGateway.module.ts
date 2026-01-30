import { Module } from '@nestjs/common';
import { UiGateway } from './uiGateway.gateway';
import { UiGatewayController } from './uiGateway.controller';
import { UserModule } from 'src/user/user.module';

@Module({
  imports: [UserModule],
  providers: [UiGateway],
  controllers: [UiGatewayController],
  exports: [UiGateway],
})
export class UiGatewayModule {}
