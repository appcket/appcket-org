import { createFileRoute } from '@tanstack/react-router';
import { useEffect } from 'react';

export const Route = createFileRoute('/login')({
  component: Login,
});

function Login() {
  useEffect(() => {
    // Redirect to the server-side login handler
    window.location.href = '/api/login';
  }, []);

  return (
    <div className="p-4 flex items-center justify-center h-screen">
      <p>Redirecting to login...</p>
    </div>
  );
}