import { Route, Routes } from 'react-router-dom';

import ProtectedRoute from 'src/common/components/ProtectedRoute';
import Resources from 'src/common/enums/resources.enum';
import { TeamPermission } from 'src/common/enums/permissions.enum';
import ViewTeams from 'src/pages/Teams/ViewTeams';
import ViewTeam from 'src/pages/Teams/ViewTeam';
import EditTeam from 'src/pages/Teams/EditTeam';
import CreateTeam from 'src/pages/Teams/CreateTeam';

const Teams = () => {
  return (
    <Routes>
      <Route
        path="/"
        element={
          <ProtectedRoute permission={[Resources.Team, TeamPermission.read]}>
            <ViewTeams />
          </ProtectedRoute>
        }
      />
      <Route
        path="/:teamId"
        element={
          <ProtectedRoute permission={[Resources.Team, TeamPermission.read]}>
            <ViewTeam />
          </ProtectedRoute>
        }
      />
      <Route
        path="/:teamId/edit"
        element={
          <ProtectedRoute permission={[Resources.Team, TeamPermission.update]}>
            <EditTeam />
          </ProtectedRoute>
        }
      />
      <Route
        path="/create"
        element={
          <ProtectedRoute permission={[Resources.Team, TeamPermission.create]}>
            <CreateTeam />
          </ProtectedRoute>
        }
      />
    </Routes>
  );
};

export default Teams;
