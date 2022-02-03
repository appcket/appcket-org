import React from 'react';
import { Route, Routes } from 'react-router-dom';

import ProtectedRoute from 'src/common/components/ProtectedRoute';
import Resources from 'src/common/enums/resources.enum';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import ViewProjects from 'src/pages/Projects/ViewProjects';

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
    </Routes>
  );
};

export default Projects;
