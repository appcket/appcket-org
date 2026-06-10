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
import { MikroORM } from '@mikro-orm/core';
import { CreateRequestContext } from '@mikro-orm/decorators/legacy';

@WebSocketGateway({
  cors: {
    origin: '*',
  },
  transports: ['websocket', 'polling'],
})
export class UiGateway implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server!: Server;

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
        const error = err instanceof Error ? err : new Error(String(err));
        this.logger.error(`Failed to parse token for client ${socket.id}`, error.stack);
        return next(new Error('Authentication error: Invalid token'));
      }
    });
  }

  @CreateRequestContext()
  async handleConnection(client: Socket) {
    const userId = client.data.userId;
    if (!userId) {
      this.logger.error(`Connection refused for client ${client.id}: No userId in socket data`);
      // Use set timeout to delay disconnect, allowing client to receive error event if needed
      setTimeout(() => client.disconnect(), 1000);
      return;
    }

    this.logger.log(`Client connecting: ${client.id} (User: ${userId})`);

    try {
      // Fetch user's organizations to join corresponding rooms
      const user = await this.userService.getUser(userId);

      if (user) {
        // Ensure organizationUsers are loaded with nested organization data
        if (!user.organizationUsers.isInitialized()) {
          await user.organizationUsers.init();
        }

        const orgIds = user.organizationUsers.map((ou) => ou.organization.id);
        this.logger.log(
          `Client ${client.id} joining rooms for organizations: ${orgIds.join(', ')}`,
        );

        orgIds.forEach((orgId) => {
          client.join(`org:${orgId}`);
        });

        this.logger.log(`✅ Client ${client.id} (User: ${userId}) connected and joined rooms.`);
      } else {
        this.logger.warn(`User ${userId} not found in database during connection setup.`);
        // Don't disconnect, stay connected but without org rooms
      }
    } catch (err) {
      const error = err instanceof Error ? err : new Error(String(err));

      this.logger.error(
        `Error during connection setup for client ${client.id}: ${error.message}`,
        error.stack,
      );
      // Stay connected even if DB fails
    }
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  /**
   * Pushes a raw event from Redpanda to targeted UI clients based on organization.
   */
  emitEvent(payload: any) {
    // Extract orgId from various possible paths in the business payload
    const orgId =
      payload.payload?.entity?.data?.organizationId ||
      payload.payload?.organizationId ||
      payload.payload?.entity?.organizationId;

    if (orgId) {
      this.logger.log(
        `Pushing event to Org Room [org:${orgId}]: ${payload.resource}:${payload.action}`,
      );
      this.server.to(`org:${orgId}`).emit('events', payload);
    } else {
      // Fallback: If no orgId is found, broadcast to all authenticated clients
      this.logger.warn(
        `Received event without organizationId, broadcasting to all: ${payload.resource}:${payload.action}`,
      );
      this.server.emit('events', payload);
    }
  }
}
