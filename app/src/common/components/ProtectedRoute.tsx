import { useQuery } from 'react-query';
import { Navigate } from 'react-router-dom';

import UserInfoQueryResponse from '../models/responses/UserInfoQueryResponse';
import Permission from '../models/Permission';
import hasPermission from 'src/common/utils/hasPermission';

const ProtectedRoute = ({
  children,
  permission,
}: {
  children: JSX.Element;
  permission: string[];
}) => {
  const userInfoQuery = useQuery<UserInfoQueryResponse>('userInfo');

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