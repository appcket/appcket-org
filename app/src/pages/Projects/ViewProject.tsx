import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid2';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import { Link, useParams } from 'react-router-dom';
import { useTranslation } from 'react-i18next';

import { useGetProject } from 'src/common/api/project';
import { useUserInfo } from 'src/common/api/user';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import hasPermission from 'src/common/utils/hasPermission';
import { ProjectPermission } from 'src/common/enums/permissions.enum';
import QueryStatuses from 'src/common/enums/queryStatuses.enum';
import Resources from 'src/common/enums/resources.enum';
import Permission from 'src/common/models/Permission';
import EditButton from 'src/common/components/buttons/EditButton';
import Loading from 'src/common/components/Loading';
import { displayUser } from 'src/common/utils/general';
import EntityHistory from 'src/common/components/EntityHistory';

const Project = () => {
  const { t } = useTranslation();
  const params = useParams();
  const projectId = params.projectId || '';
  const userInfo = useUserInfo();

  const updateProjectPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Project,
    ProjectPermission.update,
  );
  const readProjectHistoryPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Project,
    ProjectPermission.readHistory,
  );
  const { status, data, error, isFetching, isLoading } = useGetProject(projectId);

  let projectComponent;
  let entityHistoryComponent;

  if (isLoading || isFetching) {
    projectComponent = <Loading />;
  } else if (status === QueryStatuses.Error && error instanceof Error) {
    projectComponent = (
      <Typography component="p">
        {t('messages.error.error')}: {error.message}
      </Typography>
    );
  } else {
    projectComponent = (
      <Typography component="p">
        {t('messages.error.unableView')} {t('resources.project')}
      </Typography>
    );

    let updateProjectButton = <EditButton linkTo="#" variant="outlined" isDisabled={true} />;

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
          {t('labels.users')}:{' '}
          {data?.getProject.users.length === 0
            ? t('messages.info.noUsersAssociatedWith') + ' ' + t('entities.project')
            : null}
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
        <PageHeader
          title={data?.getProject.name}
          subTitle={t('pages.projects.viewProject.subTitle')}
        />

        <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
          <Grid container justifyContent="flex-end">
            <Grid>{updateProjectButton}</Grid>
          </Grid>
          <Grid size={{ xs: 12, sm: 6 }}>
            <Typography variant="body1">
              {t('entities.organization')}: {data?.getProject.organization.name}
            </Typography>
            <Typography variant="body1">
              {t('labels.description')}: {data?.getProject.description}
            </Typography>
            <Typography variant="body1">
              <Button component={Link} to={`tasks`}>
                {t('pages.projects.viewProject.viewTasks')}
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
    <Page title={`${t('entities.project')} - ${data?.getProject.name}`}>
      <div>{projectComponent}</div>
    </Page>
  );
};

export default Project;
