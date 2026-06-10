import { Global, Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { CommonService } from 'src/common/services/common.service';
import { CorrelationContext } from 'src/common/services/correlation-context.service';
import { CorrelationMiddleware } from 'src/common/middleware/correlation.middleware';
import { OutboxService } from 'src/common/services/outbox.service';
import { AuthorizationService } from 'src/common/services/authorization.service';

@Module({
  imports: [HttpModule],
  exports: [CommonService, CorrelationContext, HttpModule],
  providers: [CommonService, CorrelationContext, CorrelationMiddleware],
})
export class CommonModule {}
