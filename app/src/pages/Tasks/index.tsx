import { Route, Routes } from 'react-router-dom';

import ProtectedRoute from 'src/common/components/ProtectedRoute';
import Resources from 'src/common/enums/resources.enum';
import { TaskPermission } from 'src/common/enums/permissions.enum';
import ViewTask from 'src/pages/Tasks/ViewTask';

const Tasks = () => {
  return (
    <Routes>
      <Route
        path="/:taskId"
        element={
          <ProtectedRoute permission={[Resources.Task, TaskPermission.read]}>
            <ViewTask />
          </ProtectedRoute>
        }
      />
    </Routes>
  );
};

export default Tasks;
