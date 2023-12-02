import { Navigate } from 'react-router-dom';

import { useUserInfo } from 'src/common/api/user';
import Permission from 'src/common/models/Permission';
import hasPermission from 'src/common/utils/hasPermission';

const ProtectedRoute = ({
  children,
  permission,
}: {
  children: JSX.Element;
  permission: string[];
}) => {
  const userInfo = useUserInfo();

  if (userInfo.status === 'success') {
    if (!hasPermission(userInfo.data?.permissions as Permission[], permission[0], permission[1])) {
      return <Navigate to="/unauthorized" />;
    }
  }

  return children;
};

export default ProtectedRoute;
