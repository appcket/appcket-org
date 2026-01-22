import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Logger } from '@nestjs/common';

@WebSocketGateway({
  cors: {
    origin: '*', // We will refine this later based on config
  },
  transports: ['websocket', 'polling'],
})
export class UiGateway implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private readonly logger = new Logger(UiGateway.name);

  afterInit(server: Server) {
    this.logger.log('UI Gateway Initialized');

    // Middleware to handle authentication
    server.use((socket: Socket, next) => {
      const token = socket.handshake.auth.token;
      if (!token) {
        this.logger.warn(`Connection rejected: No token provided for client ${socket.id}`);
        return next(new Error('Authentication error: No token provided'));
      }

      // Attach token to socket data for later use in handleConnection
      socket.data.token = token;
      next();
    });
  }

  handleConnection(client: Socket) {
    this.logger.log(`Client connected: ${client.id}`);
    // TODO: verify the token here and join rooms
    this.logger.debug(
      `Client ${client.id} provided token: ${client.data.token?.substring(0, 20)}...`,
    );
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  /**
   * Pushes a raw event from Redpanda to all connected UI clients.
   * Later we will add logic to filter by user/topic.
   */
  emitEvent(payload: any) {
    this.logger.debug(`Pushing event to UI: ${JSON.stringify(payload)}`);
    this.server.emit('events', payload);
  }
}
