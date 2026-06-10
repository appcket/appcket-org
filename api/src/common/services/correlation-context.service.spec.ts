import { CorrelationContext } from './correlation-context.service';

describe('CorrelationContext', () => {
  let service: CorrelationContext;

  beforeEach(() => {
    service = new CorrelationContext();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should return undefined when no context is active', () => {
    expect(service.id).toBeUndefined();
  });

  it('should store and retrieve the correlation ID within the run callback', (done) => {
    const testId = 'test-uuid-123';

    service.run(testId, () => {
      expect(service.id).toBe(testId);
      done();
    });
  });

  it('should isolate contexts for parallel executions', (done) => {
    const id1 = 'id-1';
    const id2 = 'id-2';
    let completed = 0;

    const checkDone = () => {
      completed++;
      if (completed === 2) done();
    };

    service.run(id1, () => {
      setTimeout(() => {
        expect(service.id).toBe(id1);
        checkDone();
      }, 10);
    });

    service.run(id2, () => {
      setTimeout(() => {
        expect(service.id).toBe(id2);
        checkDone();
      }, 5);
    });
  });
});
