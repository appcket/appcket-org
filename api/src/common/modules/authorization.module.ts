import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { AuthorizationService } from 'src/common/services/authorization.service';

@Module({
  imports: [HttpModule],
  exports: [AuthorizationService, HttpModule],
  providers: [AuthorizationService],
})
export class AuthorizationModule {}
