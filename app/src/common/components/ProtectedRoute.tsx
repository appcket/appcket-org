import React from 'react';
import { Navigate } from 'react-router-dom';

import { useUserInfo } from 'src/common/api/user';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import Permission from 'src/common/models/Permission';
import hasPermission from 'src/common/utils/hasPermission';

const ProtectedRoute = ({
  children,
  permission,
}: {
  children: React.ReactNode;
  permission: string[];
}) => {
  const userInfo = useUserInfo();

  if (userInfo.status === QueryStatuses.Success) {
    if (!hasPermission(userInfo.data?.permissions as Permission[], permission[0], permission[1])) {
      return <Navigate to="/unauthorized" />;
    }
  }

  return children;
};

export default ProtectedRoute;
