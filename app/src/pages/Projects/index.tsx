import { Route, Routes } from 'react-router-dom';

import ProtectedRoute from 'src/common/components/ProtectedRoute';
import Resources from 'src/common/enums/resources.enum';
import { ProjectPermission, TaskPermission } from 'src/common/enums/permissions.enum';
import ViewProjects from 'src/pages/Projects/ViewProjects';
import ViewProject from 'src/pages/Projects/ViewProject';
import EditProject from 'src/pages/Projects/EditProject';
import CreateProject from 'src/pages/Projects/CreateProject';
import ViewProjectTasks from 'src/pages/Projects/ViewProjectTasks';
import CreateTask from 'src/pages/Tasks/CreateTask';

const Projects = () => {
  return (
    <Routes>
      <Route
        path="/"
        element={
          <ProtectedRoute permission={[Resources.Project, ProjectPermission.read]}>
            <ViewProjects />
          </ProtectedRoute>
        }
      />
      <Route
        path="/:projectId"
        element={
          <ProtectedRoute permission={[Resources.Project, ProjectPermission.read]}>
            <ViewProject />
          </ProtectedRoute>
        }
      />
      <Route
        path="/:projectId/edit"
        element={
          <ProtectedRoute permission={[Resources.Project, ProjectPermission.update]}>
            <EditProject />
          </ProtectedRoute>
        }
      />
      <Route
        path="/create"
        element={
          <ProtectedRoute permission={[Resources.Project, ProjectPermission.create]}>
            <CreateProject />
          </ProtectedRoute>
        }
      />
      <Route
        path="/:projectId/tasks"
        element={
          <ProtectedRoute permission={[Resources.Task, TaskPermission.read]}>
            <ViewProjectTasks />
          </ProtectedRoute>
        }
      />
      <Route
        path="/:projectId/tasks/create"
        element={
          <ProtectedRoute permission={[Resources.Task, TaskPermission.create]}>
            <CreateTask />
          </ProtectedRoute>
        }
      />
    </Routes>
  );
};

export default Projects;
