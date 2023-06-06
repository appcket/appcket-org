import User from 'src/common/models/User';

export const displayUser = (user: User | undefined): string => {
  if (user) {
    if (user.firstName && user.lastName) {
      return `${user.firstName} ${user.lastName}`;
    }

    if (user.firstName) {
      return `${user.firstName}`;
    }

    return user.username;
  }

  return '';
};
