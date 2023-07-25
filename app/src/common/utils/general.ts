import User from 'src/common/models/User';
import { IEntityHistory } from 'src/common/models/EntityHistory';

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

export const getUpdatedDatetime = (entityId: string, entityHistories: IEntityHistory[]) => {
  const foundEntity = entityHistories.find((history) => history.id === entityId);
  if (foundEntity) {
    if (foundEntity.updatedAt) {
      return foundEntity.updatedBy?.displayName
        ? `${formatDatetime(foundEntity.updatedAt)} by ${foundEntity.updatedBy?.displayName}`
        : `${formatDatetime(foundEntity.updatedAt)}`;
    }
  }

  return '';
};

export const getCreatedDatetime = (entityId: string, entityHistories: IEntityHistory[]) => {
  const foundEntity = entityHistories.find((history) => history.id === entityId);
  if (foundEntity) {
    if (foundEntity.createdAt) {
      return foundEntity.createdBy?.displayName
        ? `${formatDatetime(foundEntity.createdAt)} by ${foundEntity.createdBy?.displayName}`
        : `${formatDatetime(foundEntity.createdAt)}`;
    }
  }

  return '';
};
