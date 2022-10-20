import { useQuery } from '@tanstack/react-query';
import { Navigate } from 'react-router-dom';

import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import Permission from 'src/common/models/Permission';
import hasPermission from 'src/common/utils/hasPermission';

const ProtectedRoute = ({
  children,
  permission,
}: {
  children: JSX.Element;
  permission: string[];
}) => {
  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);

  if (userInfoQuery.status === 'success') {
    if (
      !hasPermission(
        userInfoQuery.data?.userInfo.permissions as Permission[],
        permission[0],
        permission[1],
      )
    ) {
      return <Navigate to="/unauthorized" />;
    }
  }

  return children;
};

export default ProtectedRoute;
