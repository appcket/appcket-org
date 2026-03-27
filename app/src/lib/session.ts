import { SessionOptions } from 'iron-session';

export interface User {
  id: string;
  name?: string;
  email?: string;
  username?: string;
  firstName?: string;
  lastName?: string;
  role?: string;
  jobTitle?: string;
  organizations?: {
    id: string;
    name: string;
  }[];
}

export interface SessionData {
  userId?: string;
  accessToken?: string;
  refreshToken?: string;
  expiresAt?: number;
}

export const sessionOptions: SessionOptions = {
  password: process.env.SESSION_SECRET || 'complex_password_at_least_32_characters_long',
  cookieName: 'appcket_session',
  cookieOptions: {
    secure: process.env.NODE_ENV === 'production',
    httpOnly: true,
    sameSite: 'lax',
    path: '/',
  },
};
