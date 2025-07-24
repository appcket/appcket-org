import { useParams } from 'react-router-dom';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';
import { useTranslation } from 'react-i18next';

import { useGetTeam } from 'src/common/api/team';
import { useUserInfo } from 'src/common/api/user';
import EditButton from 'src/common/components/buttons/EditButton';
import EntityHistory from 'src/common/components/EntityHistory';
import Loading from 'src/common/components/Loading';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import hasPermission from 'src/common/utils/hasPermission';
import { TeamPermission } from 'src/common/enums/Permissions';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import Resources from 'src/common/enums/Resources';
import Permission from 'src/common/models/Permission';
import { displayUser } from 'src/common/utils/general';

const Team = () => {
  const { t } = useTranslation();
  const params = useParams();
  const teamId = params.teamId || '';
  const userInfo = useUserInfo();

  const updateTeamPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Team,
    TeamPermission.update,
  );
  const readTeamHistoryPermission = hasPermission(
    userInfo.data?.permissions as Permission[],
    Resources.Team,
    TeamPermission.readHistory,
  );
  const { status, data, error, isFetching, isLoading } = useGetTeam(teamId);

  let teamComponent;
  let entityHistoryComponent;

  if (isLoading || isFetching) {
    teamComponent = <Loading />;
  } else if (status === QueryStatuses.Error && error instanceof Error) {
    teamComponent = (
      <Typography component="p">
        {t('messages.error.error')}: {error.message}
      </Typography>
    );
  } else {
    teamComponent = (
      <Typography component="p">
        {t('messages.error.unableView')} {t('resources.team')}
      </Typography>
    );

    let updateTeamButton = <EditButton linkTo="#" variant="outlined" isDisabled={true} />;

    if (updateTeamPermission) {
      updateTeamButton = <EditButton variant="contained" isDisabled={false} linkTo="edit" />;
    }

    if (readTeamHistoryPermission) {
      entityHistoryComponent = <EntityHistory entityId={teamId} entityType={Resources.Team} />;
    }

    const usersComponent = (
      <div>
        <Typography variant="body1">
          {t('labels.users')}:{' '}
          {data?.users.length === 0
            ? t('messages.info.noUsersAssociatedWith') + ' ' + t('entities.team')
            : null}
        </Typography>
        <List>
          {data?.users.map((user) => (
            <ListItem key={user.id}>
              <ListItemText primary={displayUser(user)} />
            </ListItem>
          ))}
        </List>
      </div>
    );
    teamComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid>{updateTeamButton}</Grid>
        </Grid>
        <Grid size={{ xs: 12, sm: 6 }}>
          <Typography variant="body1">
            {t('labels.organization')}: {data?.organization.name}
          </Typography>
          <Typography variant="body1">
            {t('labels.description')}: {data?.description}
          </Typography>
          {usersComponent}
        </Grid>
        {entityHistoryComponent}
      </Paper>
    );
  }

  return (
    <Page title={`${t('pages.teams.viewTeam.titleFragment')} - ${data?.name}`}>
      <PageHeader title={data?.name} subTitle={t('pages.teams.viewTeam.subTitle')} />
      {teamComponent}
    </Page>
  );
};

export default Team;
