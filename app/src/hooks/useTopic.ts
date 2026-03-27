import { useEffect } from 'react';
import { useSocket } from 'src/components/SocketProvider';

export interface EventEnvelope<T = any> {
  type: string;
  resource: string;
  action: string;
  id?: string;
  correlationId?: string;
  payload?: T;
  timestamp?: string;
}

type EventHandler = (envelope: EventEnvelope) => void;

/**
 * Hook to subscribe to a specific topic/event from the Socket.io stream.
 * 
 * @param topic The event name to listen for (e.g., 'events', 'outbox-events')
 * @param callback The function to execute when an event is received
 */
export const useTopic = (topic: string, callback: EventHandler) => {
  const { socket, isConnected } = useSocket();

  useEffect(() => {
    if (!socket || !isConnected) return;

    // Register the event listener
    socket.on(topic, callback);

    // Cleanup listener on unmount or dependency change
    return () => {
      socket.off(topic, callback);
    };
  }, [socket, isConnected, topic, callback]);
};
