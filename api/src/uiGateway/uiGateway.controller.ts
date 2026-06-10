import { Controller } from '@nestjs/common';
import { EventPattern, Payload } from '@nestjs/microservices';
import { UiGateway } from './uiGateway.gateway';
import { Logger } from '@nestjs/common';
import { EventEnvelope } from 'src/common/models/eventEnvelope';

@Controller()
export class UiGatewayController {
  private readonly logger = new Logger(UiGatewayController.name);

  constructor(private readonly uiGateway: UiGateway) {}

  @EventPattern('outbox-events')
  handleOutboxEvent(@Payload() data: any) {
    this.logger.debug('Received raw Kafka event');
    
    // Log the structure to see what we are dealing with
    if (data) {
      this.logger.debug(`Action: ${data.action}, Table: ${data.record?.table || 'unknown'}`);
    }

    const outboxRecord = data?.record;
    const businessPayload = outboxRecord?.payload;

    if (!businessPayload) {
      this.logger.warn('Received outbox event without business payload, skipping');
      // Some events like deletions might not have a payload in the same way
      return;
    }

    const envelope: EventEnvelope = {
      type: businessPayload.operationType || businessPayload.type || 'entity_change',
      resource:
        (typeof businessPayload.entity === 'object'
          ? businessPayload.entity?.type
          : businessPayload.entity) ||
        businessPayload.resource ||
        'unknown',
      action: data.action || 'insert',
      id: businessPayload.id || businessPayload.entity?.id,
      correlationId: outboxRecord.correlationId,
      payload: businessPayload,
      timestamp: outboxRecord.createdAt || data.metadata?.commit_timestamp,
    };

    this.logger.debug(`Forwarding standardized event: ${envelope.resource}:${envelope.action}`);

    // Forward the standardized envelope to the UI Gateway
    this.uiGateway.emitEvent(envelope);
  }
}
