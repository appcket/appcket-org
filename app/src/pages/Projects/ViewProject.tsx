import React from 'react';
import { Link, NavLink, useParams } from 'react-router-dom';
import { useQuery } from 'react-query';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

import Page from 'src/common/components/Page';
import { useGetProject } from 'src/common/api/project';
import hasPermission from 'src/common/utils/hasPermission';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import Resources from 'src/common/enums/resources.enum';
import UserInfoQueryResponse from 'src/common/models/responses/user/UserInfoQueryResponse';
import Permission from 'src/common/models/Permission';

const Project = () => {
  const params = useParams();
  const userInfoQuery = useQuery<UserInfoQueryResponse>('userInfo');

  const updateProjectPermission = hasPermission(
    userInfoQuery.data?.userInfo.permissions as Permission[],
    Resources.Project,
    ProjectPermission.update,
  );
  const { status, data, error, isFetching } = useGetProject(params.projectId!);

  let projectComponent;

  if (status === 'loading' || isFetching) {
    projectComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    projectComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    projectComponent = <Typography paragraph>Unable to view Project</Typography>;

    let updateProjectButton = (
      <Button variant="outlined" disabled>
        Edit
      </Button>
    );

    if (updateProjectPermission) {
      updateProjectButton = (
        <Button variant="contained" component={Link} to="edit">
          Edit
        </Button>
      );
    }

    const usersComponent = (
      <div>
        <Typography variant="body1">Users:</Typography>
        <List>
          {data?.users.map((user) => (
            <ListItem key={user.user_id}>
              <ListItemText primary={user.firstName} />
            </ListItem>
          ))}
        </List>
      </div>
    );

    projectComponent = (
      <div>
        <Typography variant="h4">{data?.name}</Typography>

        <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
          <Grid container justifyContent="flex-end">
            <Grid item>{updateProjectButton}</Grid>
          </Grid>
          <Grid item xs={12} sm={6}>
            <Typography variant="body1">Organization: {data?.organization.name}</Typography>
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
