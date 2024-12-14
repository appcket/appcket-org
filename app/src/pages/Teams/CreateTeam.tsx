import { useEffect } from 'react';
import { useForm } from 'react-hook-form';
import { Save, Undo } from '@mui/icons-material';
import Button from '@mui/material/Button';
import Grid from '@mui/material/Grid2';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import { useSnackbar } from 'notistack';
import { get } from 'lodash';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';

import { useCreateTeam } from 'src/common/api/team';
import { useUserInfo } from 'src/common/api/user';
import CancelButton from 'src/common/components/buttons/CancelButton';
import Loading from 'src/common/components/Loading';
import FormSelectMenu from 'src/common/components/form/FormSelectMenu';
import { FormTextField } from 'src/common/components/form/FormTextField';
import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';
import ResourceUsersGrid from 'src/common/components/ResourceUsersGrid';
import QueryStatuses from 'src/common/enums/QueryStatuses';
import CreateTeamInput from 'src/common/models/inputs/CreateTeamInput';
import Team from 'src/common/models/Team';
import User from 'src/common/models/User';
import { useStore } from 'src/common/store';
import { FormFields } from 'src/common/constants';

const CreateTeam = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();
  const {
    watch,
    formState: { isValid },
    handleSubmit,
    reset,
    control,
  } = useForm<CreateTeamInput>({
    mode: 'all',
    defaultValues: {
      name: '',
      description: '',
      organizationId: '',
    },
  });

  const watchOrganizationId = watch('organizationId', '');
  const createTeam = useCreateTeam();
  const resetSelectedUserIds = useStore((state) => state.resourceUsers.resetSelectedUserIds);
  const selectedUserIds = useStore((state) => state.resourceUsers.selectedUserIds);
  const userInfo = useUserInfo();

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
    reset({ name: '', description: '', organizationId: '' });
    useStore.setState((state) => ({
      resourceUsers: {
        ...state.resourceUsers,
        selectedUserIds: initialSelectedItemIds([] as User[], 'user_id'),
      },
    }));
  }, [reset]);

  const onSubmit = async (createTeamInput: CreateTeamInput) => {
    createTeamInput.userIds = selectedUserIds;

    createTeam.mutate(
      { createTeamInput },
      {
        onSuccess: (data) => {
          const createdTeam = data as Team;
          enqueueSnackbar(`Team created: ${createdTeam.name}`, {
            variant: 'success',
          });
          navigate('/teams');
        },
      },
    );
  };

  let organizationSelectMenu;
  let organizationUsersGrid;

  if (userInfo.isLoading || userInfo.isFetching) {
    organizationSelectMenu = <Loading />;
    organizationUsersGrid = <Loading />;
  } else if (userInfo.status === QueryStatuses.Error && userInfo.error instanceof Error) {
    organizationSelectMenu = <Typography component="p">Error: {userInfo.error.message}</Typography>;
  } else if (userInfo.isSuccess) {
    const options = userInfo.data.organizations?.map((organization) => {
      return { id: organization.id, label: organization.name };
    });
    organizationSelectMenu = (
      <FormSelectMenu
        name="organizationId"
        className="mb-4"
        control={control}
        label={t('labels.organization')}
        options={options}
        rules={{
          required: { value: true, message: t('messages.error.requiredField') },
        }}
      />
    );

    organizationUsersGrid = (
      <ResourceUsersGrid resourceType="Team" organizationId={watchOrganizationId} />
    );
  }

  const createTeamComponent = (
    <Paper elevation={1} sx={{ my: { xs: 3, md: 3 }, p: { xs: 2, md: 3 } }}>
      <Grid size={{ xs: 24, sm: 12 }} sx={{ mb: 2 }}>
        {organizationSelectMenu}

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

      {watchOrganizationId && organizationUsersGrid}

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

  return (
    <Page title={t('pages.teams.createTeam.title')}>
      <PageHeader
        title={t('pages.teams.createTeam.title')}
        subTitle={t('pages.teams.createTeam.subTitle')}
      >
        <Grid container justifyContent="flex-end">
          <Grid>
            <CancelButton linkTo="../" />
          </Grid>
        </Grid>
      </PageHeader>
      <div>{createTeamComponent}</div>
    </Page>
  );
};

export default CreateTeam;
