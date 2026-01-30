import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Logger, Inject } from '@nestjs/common';
import { UserService } from 'src/user/services/user.service';
import { CreateRequestContext, MikroORM } from '@mikro-orm/core';

@WebSocketGateway({
  cors: {
    origin: '*',
  },
  transports: ['websocket', 'polling'],
})
export class UiGateway implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private readonly logger = new Logger(UiGateway.name);

  constructor(
    @Inject(UserService) private readonly userService: UserService,
    private readonly orm: MikroORM, // Injecting ORM to provide context
  ) {}

  afterInit(server: Server) {
    this.logger.log('UI Gateway Initialized');

    // Middleware to handle authentication and basic validation
    server.use(async (socket: Socket, next) => {
      const authHeader = socket.handshake.auth.token;
      if (!authHeader) {
        this.logger.warn(`Connection rejected: No token provided for client ${socket.id}`);
        return next(new Error('Authentication error: No token provided'));
      }

      try {
        const token = authHeader.split(' ')[1];
        const payload = JSON.parse(Buffer.from(token.split('.')[1], 'base64').toString());
        socket.data.userId = payload.sub;
        socket.data.token = token;
        next();
      } catch (err) {
        this.logger.error(`Failed to parse token for client ${socket.id}`, err.stack);
        return next(new Error('Authentication error: Invalid token'));
      }
    });
  }

  @CreateRequestContext()
  async handleConnection(client: Socket) {
    const userId = client.data.userId;
    if (!userId) {
      this.logger.error(`Connection refused for client ${client.id}: No userId in socket data`);
      client.disconnect();
      return;
    }

    this.logger.log(`Client connected: ${client.id} (User: ${userId})`);

    try {
      // Fetch user's organizations to join corresponding rooms
      const user = await this.userService.getUser(userId);
      
      if (user && user.organizations) {
        const orgIds = user.organizations.getIdentifiers();
        this.logger.debug(`Client ${client.id} joining rooms for organizations: ${orgIds.join(', ')}`);

        orgIds.forEach((orgId) => {
          client.join(`org:${orgId}`);
        });
      } else {
        this.logger.warn(`User ${userId} has no organizations or was not found.`);
      }
    } catch (err) {
      this.logger.error(`Error during connection setup for client ${client.id}: ${err.message}`, err.stack);
      // Optional: Don't disconnect if the error is non-fatal (like DB being slow)
      // but for now let's see the error in your terminal
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  /**
   * Pushes a raw event from Redpanda to targeted UI clients based on organization.
   */
  emitEvent(payload: any) {
    const orgId = payload.payload?.organizationId || payload.payload?.entity?.data?.organizationId;

    if (orgId) {
      this.logger.debug(`Pushing event to Org Room [org:${orgId}]: ${payload.resource}:${payload.action}`);
      this.server.to(`org:${orgId}`).emit('events', payload);
    } else {
      // Fallback: If no orgId is found, we might want to broadcast or ignore. 
      // For now, let's log it.
      this.logger.warn(`Received event without organizationId, broadcasting to all: ${payload.resource}:${payload.action}`);
      this.server.emit('events', payload);
    }
  }
}
