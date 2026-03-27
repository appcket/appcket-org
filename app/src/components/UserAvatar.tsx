import { Avatar, AvatarProps } from '@mantine/core';
import { useMemo } from 'react';

interface UserAvatarProps extends AvatarProps {
  firstName?: string;
  lastName?: string;
  username?: string;
}

const BRIGHT_COLORS = [
  'blue',
  'cyan',
  'grape',
  'indigo',
  'lime',
  'orange',
  'pink',
  'red',
  'teal',
  'violet',
];

export function UserAvatar({ firstName, lastName, username, ...others }: UserAvatarProps) {
  const initials = useMemo(() => {
    if (firstName && lastName) {
      return `${firstName.charAt(0)}${lastName.charAt(0)}`.toUpperCase();
    }
    if (firstName) {
      return firstName.charAt(0).toUpperCase();
    }
    if (username) {
      return username.charAt(0).toUpperCase();
    }
    return '?';
  }, [firstName, lastName, username]);

  const randomColor = useMemo(() => {
    // Use the initials to derive a consistent index so the color doesn't change on every render
    const charCodeSum = initials.split('').reduce((acc, char) => acc + char.charCodeAt(0), 0);
    return BRIGHT_COLORS[charCodeSum % BRIGHT_COLORS.length];
  }, [initials]);

  return (
    <Avatar radius="xl" color={randomColor} variant="filled" {...others}>
      {initials}
    </Avatar>
  );
}
