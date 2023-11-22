import { Link, useParams } from 'react-router-dom';
import Button from '@mui/material/Button';
import { useQuery } from '@tanstack/react-query';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import { useGetProject } from 'src/common/api/project';
import hasPermission from 'src/common/utils/hasPermission';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoResponse from 'src/common/models/responses/UserInfoResponse';
import Permission from 'src/common/models/Permission';
import EditButton from 'src/common/components/buttons/EditButton';
import Loading from 'src/common/components/Loading';
import { displayUser } from 'src/common/utils/general';
import EntityHistory from 'src/common/components/EntityHistory';

const Project = () => {
  const params = useParams();
  const projectId = params.projectId || '';
  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);

  const updateProjectPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Project,
    ProjectPermission.update,
  );
  const readProjectHistoryPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Project,
    ProjectPermission.readHistory,
  );
  const { status, data, error, isFetching } = useGetProject(projectId);

  let projectComponent;
  let entityHistoryComponent;

  if (status === 'loading' || isFetching) {
    projectComponent = <Loading />;
  } else if (status === 'error' && error instanceof Error) {
    projectComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    projectComponent = <Typography paragraph>Unable to view Project</Typography>;

    let updateProjectButton = <EditButton variant="outlined" isDisabled={true} />;

    if (updateProjectPermission) {
      updateProjectButton = <EditButton linkTo="edit" />;
    }

    if (readProjectHistoryPermission) {
      entityHistoryComponent = (
        <EntityHistory entityId={projectId} entityType={Resources.Project} />
      );
    }

    const usersComponent = (
      <div>
        <Typography variant="body1">
          Users:{' '}
          {data?.getProject.users.length === 0 ? 'No users associated with this project' : null}
        </Typography>
        <List>
          {data?.getProject.users.map((user) => (
            <ListItem key={user.id}>
              <ListItemText primary={displayUser(user)} />
            </ListItem>
          ))}
        </List>
      </div>
    );

    projectComponent = (
      <div>
        <PageHeader title={data?.getProject.name} subTitle="Project details" />

        <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
          <Grid container justifyContent="flex-end">
            <Grid item>{updateProjectButton}</Grid>
          </Grid>
          <Grid item xs={12} sm={6}>
            <Typography variant="body1">
              Organization: {data?.getProject.organization.name}
            </Typography>
            <Typography variant="body1">Description: {data?.getProject.description}</Typography>
            <Typography variant="body1">
              <Button component={Link} to={`tasks`}>
                View Tasks
              </Button>
            </Typography>
            {usersComponent}
          </Grid>
          {entityHistoryComponent}
        </Paper>
      </div>
    );
  }

  return (
    <Page title={`Project - ${data?.getProject.name}`}>
      <div>{projectComponent}</div>
    </Page>
  );
};

export default Project;
