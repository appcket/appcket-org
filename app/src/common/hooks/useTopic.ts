import { useEffect } from 'react';
import { useSocket } from 'src/context/SocketProvider';

type EventHandler = (data: any) => void;

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
