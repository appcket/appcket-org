import { Injectable } from '@nestjs/common';
import { AsyncLocalStorage } from 'async_hooks';

@Injectable()
export class CorrelationContext {
  private static readonly storage = new AsyncLocalStorage<Map<string, string>>();

  run(correlationId: string, callback: () => void) {
    const store = new Map<string, string>().set('correlationId', correlationId);
    CorrelationContext.storage.run(store, callback);
  }

  get id(): string | undefined {
    return CorrelationContext.storage.getStore()?.get('correlationId');
  }
}
