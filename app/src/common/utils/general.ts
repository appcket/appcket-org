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

export const formatDatetime = (datetime: string): string => {
  return new Date(datetime).toLocaleDateString() + ' - ' + new Date(datetime).toLocaleTimeString();
};

export const displayDatetimeAndUser = (datetime: string, user: User) => {
  return user
    ? `${formatDatetime(datetime)} by ${displayUser(user)}`
    : `${formatDatetime(datetime)}`;

  return '';
};

export const isJson = (string: string) => {
  try {
    JSON.parse(string);
  } catch (e) {
    return false;
  }

  return true;
};
