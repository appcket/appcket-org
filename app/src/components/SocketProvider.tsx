import React, { createContext, useContext, useEffect, useState } from 'react';
import { io, Socket } from 'socket.io-client';

interface SocketContextType {
  socket: Socket | null;
  isConnected: boolean;
}

const SocketContext = createContext<SocketContextType>({
  socket: null,
  isConnected: false,
});

export const useSocket = () => useContext(SocketContext);

interface SocketProviderProps {
  children: React.ReactNode;
  accessToken?: string;
}

export const SocketProvider: React.FC<SocketProviderProps> = ({ children, accessToken }) => {
  const [socket, setSocket] = useState<Socket | null>(null);
  const [isConnected, setIsConnected] = useState(false);

  useEffect(() => {
    if (!accessToken) return;

    // Use the API URL from environment variables
    const gateway = import.meta.env?.VITE_API_URL ?? 'https://api.appcket.test';

    console.log('🔌 Initializing socket connection to:', gateway);

    // Connect to the API Gateway (UiGateway)
    const socketInstance = io(gateway, {
      transports: ['websocket', 'polling'],
      reconnectionAttempts: 5,
      auth: {
        token: `Bearer ${accessToken}`,
      },
    });

    socketInstance.on('connect', () => {
      console.log('✅ Socket connected:', socketInstance.id);
      setIsConnected(true);
    });

    socketInstance.on('disconnect', () => {
      console.log('❌ Socket disconnected');
      setIsConnected(false);
    });

    socketInstance.on('connect_error', (err) => {
      console.error('⚠️ Socket connection error:', err.message);
    });

    setSocket(socketInstance);

    return () => {
      console.log('🔌 Disconnecting socket...');
      socketInstance.disconnect();
    };
  }, [accessToken]);

  return (
    <SocketContext.Provider value={{ socket, isConnected }}>{children}</SocketContext.Provider>
  );
};
