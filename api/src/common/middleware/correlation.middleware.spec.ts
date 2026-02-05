import { CorrelationMiddleware } from './correlation.middleware';
import { CorrelationContext } from '../services/correlation-context.service';
import { Request, Response } from 'express';

describe('CorrelationMiddleware', () => {
  let middleware: CorrelationMiddleware;
  let context: CorrelationContext;

  beforeEach(() => {
    context = new CorrelationContext();
    middleware = new CorrelationMiddleware(context);
  });

  it('should be defined', () => {
    expect(middleware).toBeDefined();
  });

  it('should use existing X-Correlation-ID header', () => {
    const existingId = 'existing-uuid';
    const req = {
      headers: { 'x-correlation-id': existingId },
    } as unknown as Request;
    
    const res = {
      set: jest.fn(),
    } as unknown as Response;
    
    const next = jest.fn();
    const runSpy = jest.spyOn(context, 'run');

    middleware.use(req, res, next);

    expect(res.set).toHaveBeenCalledWith('X-Correlation-ID', existingId);
    expect(runSpy).toHaveBeenCalledWith(existingId, next);
  });

  it('should generate a new ID if header is missing', () => {
    const req = {
      headers: {},
    } as unknown as Request;
    
    const res = {
      set: jest.fn(),
    } as unknown as Response;
    
    const next = jest.fn();
    const runSpy = jest.spyOn(context, 'run');

    middleware.use(req, res, next);

    expect(res.set).toHaveBeenCalledWith('X-Correlation-ID', expect.any(String));
    // Verify it looks like a UUID (roughly)
    expect(res.set).toHaveBeenCalledWith('X-Correlation-ID', expect.stringMatching(/^[0-9a-fA-F-]{36}$/));
    
    const generatedId = (res.set as jest.Mock).mock.calls[0][1];
    expect(runSpy).toHaveBeenCalledWith(generatedId, next);
  });
});
