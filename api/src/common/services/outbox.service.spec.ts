import { Test, TestingModule } from '@nestjs/testing';
import { EntityManager } from '@mikro-orm/core';
import { OutboxService } from './outbox.service';
import { CorrelationContext } from './correlation-context.service';
import { Outbox } from '../models/outbox.entity';

describe('OutboxService', () => {
  let service: OutboxService;
  let em: EntityManager;
  let correlationContext: CorrelationContext;

  const mockEntityManager = {
    create: jest.fn(),
    persist: jest.fn(),
  };

  const mockCorrelationContext = {
    id: 'default-mock-id',
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        OutboxService,
        { provide: EntityManager, useValue: mockEntityManager },
        { provide: CorrelationContext, useValue: mockCorrelationContext },
      ],
    }).compile();

    service = module.get<OutboxService>(OutboxService);
    em = module.get<EntityManager>(EntityManager);
    correlationContext = module.get<CorrelationContext>(CorrelationContext);

    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should create an outbox entry with the correlation ID from context', async () => {
    const payload = { event: 'test' };
    const contextId = 'context-uuid-123';
    
    // Mock the context getter
    Object.defineProperty(correlationContext, 'id', { get: () => contextId });
    
    const mockOutbox = new Outbox();
    mockEntityManager.create.mockReturnValue(mockOutbox);

    await service.create(payload);

    expect(mockEntityManager.create).toHaveBeenCalledWith(Outbox, {
      payload,
      correlationId: contextId,
    });
    expect(mockEntityManager.persist).toHaveBeenCalledWith(mockOutbox);
  });

  it('should default to "system" if no correlation ID is present', async () => {
    const payload = { event: 'test' };
    
    // Mock undefined context ID
    Object.defineProperty(correlationContext, 'id', { get: () => undefined });

    const mockOutbox = new Outbox();
    mockEntityManager.create.mockReturnValue(mockOutbox);

    await service.create(payload);

    expect(mockEntityManager.create).toHaveBeenCalledWith(Outbox, {
      payload,
      correlationId: 'system',
    });
  });
});
