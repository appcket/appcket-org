import { NavLink, useParams } from 'react-router-dom';
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

const Project = () => {
  const params = useParams();
  const projectId = params.projectId || '';
  const userInfoQuery = useQuery<UserInfoResponse>(['userInfo']);

  const updateProjectPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Project,
    ProjectPermission.update,
  );
  const { status, data, error, isFetching } = useGetProject(projectId);

  let projectComponent;

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

    const usersComponent = (
      <div>
        <Typography variant="body1">
          Users: {data?.users.length === 0 ? 'No users associated with this project' : null}
        </Typography>
        <List>
          {data?.users.map((user) => (
            <ListItem key={user.id}>
              <ListItemText primary={user.firstName} />
            </ListItem>
          ))}
        </List>
      </div>
    );

    projectComponent = (
      <div>
        <PageHeader title={data?.name} subTitle="Project details" />

        <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
          <Grid container justifyContent="flex-end">
            <Grid item>{updateProjectButton}</Grid>
          </Grid>
          <Grid item xs={12} sm={6}>
            <Typography variant="body1">Organization: {data?.organization.name}</Typography>
            <Typography variant="body1">Description: {data?.description}</Typography>
            <Typography variant="body1">
              <NavLink to={`tasks`}>View Tasks</NavLink>
            </Typography>
            {usersComponent}
          </Grid>
        </Paper>
      </div>
    );
  }

  return (
    <Page title={`Project - ${data?.name}`}>
      <div>{projectComponent}</div>
    </Page>
  );
};

export default Project;
