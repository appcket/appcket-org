import { Test, TestingModule } from '@nestjs/testing';
import { of } from 'rxjs';
import { AppController } from './app.controller';
import { AppService } from './app.service';

describe('AppController', () => {
  let appController: AppController;
  let mockClientKafka: any;

  beforeEach(async () => {
    mockClientKafka = {
      connect: jest.fn(),
      close: jest.fn(),
      emit: jest.fn(),
      send: jest.fn(),
    };

    const app: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [
        AppService,
        {
          provide: 'EVENT_SERVICE',
          useValue: mockClientKafka,
        },
      ],
    }).compile();

    appController = app.get<AppController>(AppController);
  });

  describe('root', () => {
    it('should return "Appcket API"', () => {
      expect(appController.getHello()).toBe('Appcket API');
    });
  });

  describe('sendTestEvent', () => {
    it('should emit an event and return status sent', () => {
      const result = appController.sendTestEvent();
      expect(result).toEqual({ status: 'sent' });
      expect(mockClientKafka.emit).toHaveBeenCalledWith('outbox-events', { hello: 'world!!!' });
    });
  });

  describe('sendRequest', () => {
    it('should send a request and return the response', async () => {
      const mockResponse = { pong: true };
      mockClientKafka.send.mockReturnValue(of(mockResponse));

      const result = await appController.sendRequest();
      expect(result).toEqual(mockResponse);
      expect(mockClientKafka.send).toHaveBeenCalledWith('outbox-events', { ping: 'pong' });
    });
  });
});
