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

export const isJson = (string: string) => {
  try {
    JSON.parse(string);
  } catch (e) {
    return false;
  }

  return true;
};

export const getOrderByInnerFieldName = (orderByFieldName: string) => {
  let orderByInnerFieldName = '';
  switch (orderByFieldName) {
    case 'taskStatusType':
      orderByInnerFieldName = 'name';
      break;
    case 'assignedTo':
      orderByInnerFieldName = 'firstName';
      break;
    default:
      break;
  }

  return orderByInnerFieldName;
};
