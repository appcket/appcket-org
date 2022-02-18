import React from 'react';
import { Route, Routes } from 'react-router-dom';

import ProtectedRoute from 'src/common/components/ProtectedRoute';
import Resources from 'src/common/enums/resources.enum';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import ViewProjects from 'src/pages/Projects/ViewProjects';
import ViewProject from 'src/pages/Projects/ViewProject';
import EditProject from 'src/pages/Projects/EditProject';
import CreateProject from 'src/pages/Projects/CreateProject';

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
    </Routes>
  );
};

export default Projects;
