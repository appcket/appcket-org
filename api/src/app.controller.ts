import { Controller, Get, Post, Inject, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { ClientKafka } from '@nestjs/microservices';
import { lastValueFrom } from 'rxjs';
import { AppService } from './app.service';

@Controller()
export class AppController implements OnModuleInit, OnModuleDestroy {
  constructor(
    private readonly appService: AppService,
    @Inject('EVENT_SERVICE') private readonly client: ClientKafka,
  ) {}

  async onModuleInit() {
    await this.client.connect();
  }

  async onModuleDestroy() {
    await this.client.close();
  }

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  // Fire-and-forget test endpoint
  @Post('send-event')
  sendTestEvent() {
    this.client.emit('twitch-chat', { hello: 'world!!!' });
    return { status: 'sent' };
  }

  // Request-response example (await the reply)
  @Post('send-request')
  async sendRequest() {
    const response$ = this.client.send('twitch-chat', { ping: 'pong' });
    const res = await lastValueFrom(response$);
    return res;
  }
}
