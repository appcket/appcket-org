import { Route, Routes } from 'react-router-dom';

import ProtectedRoute from 'src/common/components/ProtectedRoute';
import Resources from 'src/common/enums/Resources';
import { TaskPermission } from 'src/common/enums/Permissions';
import ViewTask from 'src/pages/Tasks/ViewTask';
import EditTask from 'src/pages/Tasks/EditTask';

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
      <Route
        path="/:taskId/edit"
        element={
          <ProtectedRoute permission={[Resources.Task, TaskPermission.update]}>
            <EditTask />
          </ProtectedRoute>
        }
      />
    </Routes>
  );
};

export default Tasks;
