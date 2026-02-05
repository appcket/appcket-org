import { Global, Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { CommonService } from 'src/common/services/common.service';
import { CorrelationContext } from '../services/correlation-context.service';
import { CorrelationMiddleware } from '../middleware/correlation.middleware';
import { OutboxService } from '../services/outbox.service';

@Global()
@Module({
  imports: [HttpModule],
  exports: [CommonService, HttpModule, CorrelationContext, OutboxService],
  providers: [CommonService, CorrelationContext, CorrelationMiddleware, OutboxService],
})
export class CommonModule {}
