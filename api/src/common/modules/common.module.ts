import { Global, Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { CommonService } from '@/common/services/common.service';
import { CorrelationContext } from '@/common/services/correlation-context.service';
import { CorrelationMiddleware } from '@/common/middleware/correlation.middleware';
import { OutboxService } from '@/common/services/outbox.service';
import { AuthorizationService } from '@/common/services/authorization.service';

@Module({
  imports: [HttpModule],
  exports: [CommonService, CorrelationContext, HttpModule],
  providers: [CommonService, CorrelationContext, CorrelationMiddleware],
})
export class CommonModule {}
