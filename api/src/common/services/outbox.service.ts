import { Injectable } from '@nestjs/common';
import { EntityManager } from '@mikro-orm/postgresql';
import { CorrelationContext } from 'src/common/services/correlation-context.service';
import { Outbox } from 'src/common/models/outbox.entity';

@Injectable()
export class OutboxService {
  constructor(
    private readonly em: EntityManager,
    private readonly context: CorrelationContext,
  ) {}

  /**
   * Creates an outbox entry with the current correlation ID automatically attached.
   */
  async create(payload: any): Promise<Outbox> {
    const outbox = this.em.create(Outbox, {
      payload,
      correlationId: this.context.id || 'system',
    });

    this.em.persist(outbox);

    // We don't flush here; we rely on the caller's transaction/flush cycle
    // to ensure the outbox record is committed atomically with the business data.
    return outbox;
  }
}
