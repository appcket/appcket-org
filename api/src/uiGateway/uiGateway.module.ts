import { Module } from '@nestjs/common';
import { UiGateway } from './uiGateway.gateway';
import { UiGatewayController } from './uiGateway.controller';

@Module({
  providers: [UiGateway],
  controllers: [UiGatewayController],
  exports: [UiGateway],
})
export class UiGatewayModule {}
