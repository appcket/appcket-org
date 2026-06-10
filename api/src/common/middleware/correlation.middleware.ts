import { Injectable, NestMiddleware } from '@nestjs/common';
import * as crypto from 'crypto';
import { Request, Response, NextFunction } from 'express';

import { CorrelationContext } from 'src/common/services/correlation-context.service';

@Injectable()
export class CorrelationMiddleware implements NestMiddleware {
  constructor(private readonly context: CorrelationContext) {}

  use(req: Request, res: Response, next: NextFunction) {
    // 1. Grab from header or generate a new one
    const correlationId = (req.headers['x-correlation-id'] as string) || crypto.randomUUID();

    // 2. Set the header on the response so the UI can see it too
    res.set('X-Correlation-ID', correlationId);

    // 3. Wrap the rest of the request lifecycle in the ALS context
    this.context.run(correlationId, next);
  }
}
