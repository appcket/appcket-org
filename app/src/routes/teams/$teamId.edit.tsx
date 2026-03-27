import { createFileRoute, Link, useNavigate } from '@tanstack/react-router';
import {
  Stack,
  Card,
  Group,
  Button,
  TextInput,
  Textarea,
  Box,
  LoadingOverlay,
  Breadcrumbs,
  Anchor,
  Text,
  Skeleton,
} from '@mantine/core';
import { useForm } from '@tanstack/react-form';
import { z } from 'zod';
import { notifications } from '@mantine/notifications';
import { HiOutlineCheck, HiOutlineArrowPath, HiOutlineChevronLeft } from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';
import { useEffect } from 'react';
import { PageHeader } from 'src/components/PageHeader';
import { useGetTeam, updateTeamAction } from 'src/hooks/useTeams';
import { UserMultiSelect } from 'src/components/Form/UserMultiSelect';
import { requirePermission, TeamPermission } from 'src/lib/permissions';
import { Resources } from 'src/hooks/useHistory';

export const Route = createFileRoute('/teams/$teamId/edit')({
  beforeLoad: requirePermission(Resources.Team, TeamPermission.update, '/teams'),
  component: EditTeam,
});

const teamSchema = z.object({
  id: z.string(),
  name: z.string().min(2, 'Name must have at least 2 letters'),
  description: z.string().optional(),
  organizationId: z.string(),
  userIds: z.array(z.string()).default([]),
});

function EditTeam() {
  const { teamId } = Route.useParams();
  const navigate = useNavigate();

  const { data: team, isLoading: isTeamLoading } = useGetTeam(teamId);

  const form = useForm({
    defaultValues: {
      id: teamId,
      name: team?.name || '',
      description: team?.description || '',
      organizationId: team?.organization?.id || '',
      userIds: team?.users?.map((u: any) => u.id) || [],
    },
    onSubmit: async ({ value }) => {
      try {
        await updateTeamAction({ data: value as any });
        notifications.show({
          title: m.common_updated(),
          message: m.messages_success_teamupdated({ name: value.name }),
          color: 'green',
          icon: <HiOutlineCheck />,
        });
        navigate({ to: '/teams/$teamId', params: { teamId } as any });
      } catch (error) {
        notifications.show({
          title: m.messages_error_error(),
          message: m.messages_error_teamupdatefailed(),
          color: 'red',
        });
      }
    },
  });

  useEffect(() => {
    if (team) {
      form.reset({
        id: teamId,
        name: team.name,
        description: team.description || '',
        organizationId: team.organization?.id,
        userIds: team.users?.map((u) => u.id),
      });
    }
  }, [team, form, teamId]);

  const breadcrumbs = [
    { title: m.common_navigation_teams(), to: '/teams' },
    { title: team?.name || '...', to: `/teams/${teamId}` },
    { title: m.common_edit(), to: `/teams/${teamId}/edit` },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

  const isLoading = isTeamLoading;

  const pageTitle = isLoading ? '...' : `${m.pages_teams_editteam_titlefragment()}: ${team?.name}`;

  return (
    <Stack gap="xl" style={{ position: 'relative', minHeight: '400px' }}>
      <form.Subscribe
        selector={(state) => state.isSubmitting}
        children={(isSubmitting) => (
          <LoadingOverlay visible={isSubmitting} overlayProps={{ blur: 2 }} />
        )}
      />

      <Box>
        <Breadcrumbs mb="xs">{breadcrumbs}</Breadcrumbs>
        <PageHeader
          title={pageTitle}
          subTitle={m.pages_teams_editteam_subtitle()}
        >
          <Button
            component={Link}
            to="/teams/$teamId"
            params={{ teamId } as any}
            variant="light"
            color="gray"
            leftSection={<HiOutlineChevronLeft />}
          >
            {m.common_cancel()}
          </Button>
        </PageHeader>
      </Box>

      <form
        onSubmit={(e) => {
          e.preventDefault();
          e.stopPropagation();
          form.handleSubmit();
        }}
      >
        <Card shadow="sm" padding="xl" radius="md" withBorder>
          <Stack gap="md">
            {isLoading ? (
              <>
                <Skeleton height={40} mb="md" />
                <Skeleton height={100} mb="md" />
                <Skeleton height={40} />
              </>
            ) : (
              <>
                <form.Field
                  name="name"
                  validators={{
                    onBlur: ({ value }: { value: string }) => {
                      const res = teamSchema.shape.name.safeParse(value);
                      return res.success ? undefined : res.error.issues[0]?.message;
                    },
                  }}
                  children={(field) => (
                    <TextInput
                      label={m.labels_teamname()}
                      placeholder="..."
                      value={field.state.value}
                      error={
                        field.state.meta.isTouched && field.state.meta.errors.length > 0
                          ? field.state.meta.errors[0]
                          : undefined
                      }
                      onBlur={field.handleBlur}
                      onChange={(e) => field.handleChange(e.target.value)}
                    />
                  )}
                />

                <form.Field
                  name="description"
                  validators={{
                    onBlur: ({ value }: { value: string | undefined }) => {
                      const res = teamSchema.shape.description.safeParse(value);
                      return res.success ? undefined : res.error.issues[0]?.message;
                    },
                  }}
                  children={(field) => (
                    <Textarea
                      label={m.labels_description()}
                      placeholder="..."
                      rows={4}
                      value={field.state.value}
                      error={
                        field.state.meta.isTouched && field.state.meta.errors.length > 0
                          ? field.state.meta.errors[0]
                          : undefined
                      }
                      onBlur={field.handleBlur}
                      onChange={(e) => field.handleChange(e.target.value)}
                    />
                  )}
                />

                <form.Field
                  name="userIds"
                  children={(field) => (
                    <UserMultiSelect
                      organizationId={team?.organization?.id || ''}
                      value={field.state.value}
                      onChange={(values) => field.handleChange(values)}
                      onBlur={field.handleBlur}
                      error={
                        field.state.meta.isTouched && field.state.meta.errors.length > 0
                          ? field.state.meta.errors[0]
                          : undefined
                      }
                    />
                  )}
                />
              </>
            )}

            <Group justify="flex-end" mt="md">
              <form.Subscribe
                selector={(state) => [state.canSubmit, state.isSubmitting, state.isDirty]}
                children={([canSubmit, isSubmitting, isDirty]) => (
                  <>
                    <Button
                      variant="outline"
                      color="gray"
                      onClick={() => form.reset()}
                      leftSection={<HiOutlineArrowPath />}
                      disabled={!isDirty || (isSubmitting as boolean)}
                    >
                      {m.common_reset()}
                    </Button>
                    <Button
                      type="submit"
                      color="appBlue"
                      loading={isSubmitting as boolean}
                      disabled={!canSubmit || !isDirty}
                    >
                      {m.common_save()}
                    </Button>
                  </>
                )}
              />
            </Group>
          </Stack>
        </Card>
      </form>
    </Stack>
  );
}
