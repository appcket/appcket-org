import { useEffect } from 'react';
import { Save, Undo } from '@mui/icons-material';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { get } from 'lodash';
import { useSnackbar } from 'notistack';
import { useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { useNavigate, useParams } from 'react-router-dom';

import { useGetTeam, useUpdateTeam } from 'src/common/api/team';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';
import { FormTextField } from 'src/common/components/form/FormTextField';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import UpdateTeamInput from 'src/common/models/inputs/UpdateTeamInput';
import Team from 'src/common/models/Team';
import User from 'src/common/models/User';
import { useStore } from 'src/common/store';
import { FormFields } from 'src/common/constants';

const EditTeam = () => {
  const { t } = useTranslation();
  const params = useParams();
  let teamId = '';
  if (params.teamId) {
    teamId = params.teamId;
  }
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<UpdateTeamInput>({
    mode: 'all',
    defaultValues: {
      name: '',
    },
  });

  const getTeamQuery = useGetTeam(teamId);
  const updateTeam = useUpdateTeam();
  const resetSelectedUserIds = useStore((state) => state.resourceUsers.resetSelectedUserIds);
  const selectedUserIds = useStore((state) => state.resourceUsers.selectedUserIds);

  const initialSelectedItemIds: <T>(items: T[], key: string) => string[] = (
    items,
    key,
  ): string[] => {
    if (items) {
      return items.map((item) => get(item, key));
    }
    return [];
  };

  useEffect(() => {
    reset({
      name: getTeamQuery?.data?.name ?? '',
      description: getTeamQuery?.data?.description ?? '',
    });
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds(getTeamQuery?.data?.users as User[], 'id'),
      },
    }));
  }, [reset, getTeamQuery.data]);

  useEffect(() => {
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        initialSelectedUserIds: initialSelectedItemIds(getTeamQuery?.data?.users as User[], 'id'),
      },
    }));
  }, [getTeamQuery?.data?.users]);

  let editTeamComponent;

  if (getTeamQuery.isFetching) {
    editTeamComponent = <Loading />;
  } else if (getTeamQuery.status === QueryStatuses.Error && getTeamQuery.error instanceof Error) {
    editTeamComponent = <Typography component="p">Error: {getTeamQuery.error.message}</Typography>;
  } else if (getTeamQuery.isSuccess) {
    editTeamComponent = (
      <Typography component="p">
        {t('messages.error.unableEdit')} {t('resources.team')}
      </Typography>
    );

    const onSubmit = async (updateTeamInput: UpdateTeamInput) => {
      updateTeamInput.organizationId = getTeamQuery.data.organization.id;
      updateTeamInput.id = getTeamQuery.data.id ? getTeamQuery.data.id : '';
      updateTeamInput.userIds = [...selectedUserIds];

      updateTeam.mutate(
        { updateTeamInput },
        {
          onSuccess: (data) => {
            const updatedTeam = data as Team;
            enqueueSnackbar(
              `${t('entities.team')} ${t('common.updated').toLowerCase()}: ${updatedTeam.name}`,
              {
                variant: 'success',
              },
            );
            navigate('/teams');
          },
        },
      );
    };

    editTeamComponent = (
      <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
        <Grid container justifyContent="flex-end">
          <Grid>
            <CancelButton linkTo={`../${teamId}`} />
          </Grid>
        </Grid>
        <Typography variant="body1" sx={{ mb: 3 }}>
          {t('labels.organization')}: {getTeamQuery.data.organization.name}
        </Typography>
        <Grid size={{ xs: 24, sm: 12 }} sx={{ mb: 2 }}>
          <FormTextField
            name="name"
            control={control}
            label={t('labels.teamName')}
            rules={{
              required: { value: true, message: t('messages.error.requiredField') },
              maxLength: {
                value: FormFields.team.name.maxLength,
                message: t('messages.error.fieldLessThan_other', {
                  count: FormFields.team.name.maxLength,
                }),
              },
              minLength: {
                value: FormFields.team.name.minLength,
                message: t('messages.error.fieldMoreThan_one'),
              },
            }}
          />
        </Grid>

        <FormTextField
          name="description"
          control={control}
          label={t('labels.description')}
          multiline
          rows={3}
          rules={{
            maxLength: {
              value: FormFields.team.description.maxLength,
              message: t('messages.error.fieldLessThan_other', {
                count: FormFields.team.description.maxLength,
              }),
            },
          }}
        />

        {/* instead of passing selectedUsers prop to child components, we use zustand to hold local state.
            In this case, it tracks initially selected users and user-selected users so the 
            parent component can have this data and send it back to the api onSubmit*/}
        <ResourceUsersGrid
          resourceType={t('entities.team')}
          organizationId={getTeamQuery.data.organization.id}
        />

        <Grid container justifyContent="flex-end" sx={{ mt: 3 }}>
          <Grid>
            <Button
              onClick={() => {
                reset();
                resetSelectedUserIds();
              }}
              variant="outlined"
              startIcon={<Undo />}
            >
              {t('common.reset')}
            </Button>
            <Button
              onClick={handleSubmit(onSubmit)}
              variant="contained"
              disabled={!isValid}
              startIcon={<Save />}
              sx={{ mx: 1 }}
            >
              {t('common.save')}
            </Button>
          </Grid>
        </Grid>
      </Paper>
    );
  }

  return (
    <Page title={`${t('pages.teams.editTeam.titleFragment')} - ${getTeamQuery.data?.name}`}>
      <PageHeader title={getTeamQuery.data?.name} subTitle={t('pages.teams.editTeam.subTitle')} />
      <div>{editTeamComponent}</div>
    </Page>
  );
};

export default EditTeam;
