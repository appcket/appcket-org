import { useEffect } from 'react';
import { createFileRoute, Link, useNavigate } from '@tanstack/react-router';
import {
  Stack,
  Card,
  Group,
  Button,
  TextInput,
  Textarea,
  Box,
  Breadcrumbs,
  Anchor,
  Select,
} from '@mantine/core';
import { useForm, useStore } from '@tanstack/react-form';
import { z } from 'zod';
import { notifications } from '@mantine/notifications';
import { useUserInfo } from 'src/hooks/useUser';
import {
  HiOutlineCheck,
  HiOutlineChevronLeft,
  HiOutlinePlus,
  HiOutlineBuildingOffice2
} from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';
import { PageHeader } from 'src/components/PageHeader';
import { createTeamAction } from 'src/hooks/useTeams';
import { UserMultiSelect } from 'src/components/Form/UserMultiSelect';
import { redirect } from '@tanstack/react-router';
import { requirePermission, TeamPermission } from 'src/lib/permissions';
import { Resources } from 'src/hooks/useHistory';

export const Route = createFileRoute('/teams/create')({
  beforeLoad: requirePermission(Resources.Team, TeamPermission.create, '/teams'),
  component: CreateTeam,
});

const teamSchema = z.object({
  name: z.string().min(2, 'Name must have at least 2 letters'),
  description: z.string().optional(),
  organizationId: z.string().min(1, 'Organization is required'),
  userIds: z.array(z.string()).default([]),
});

function CreateTeam() {
  const navigate = useNavigate();
  const { data: userInfo } = useUserInfo();

  const form = useForm({
    defaultValues: {
      name: '',
      description: '',
      organizationId: '',
      userIds: [] as string[],
    },
    onSubmit: async ({ value }) => {
      try {
        const result = await createTeamAction({ data: value as any });
        notifications.show({
          title: m.common_created(),
          message: m.messages_success_teamcreated({ name: result.name }),
          color: 'green',
          icon: <HiOutlineCheck />,
        });
        navigate({ to: '/teams/$teamId', params: { teamId: result.id } as any });
      } catch (error) {
        notifications.show({
          title: m.messages_error_error(),
          message: m.messages_error_teamcreatefailed(),
          color: 'red',
        });
      }
    },
  });

  const organizationId = useStore(form.store, (state) => state.values.organizationId);

  useEffect(() => {
    if (userInfo?.organizations?.length === 1 && !organizationId) {
      form.setFieldValue('organizationId', userInfo.organizations[0].id);
    }
  }, [userInfo, organizationId, form]);

  const organizationOptions = (userInfo?.organizations || []).map((org) => ({
    value: org.id,
    label: org.name,
  }));

  const breadcrumbs = [
    { title: m.common_navigation_teams(), to: '/teams' },
    { title: m.pages_teams_createteam_title(), to: '/teams/create' },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

  return (
    <Stack gap="xl">
      <Box>
        <Breadcrumbs mb="xs">{breadcrumbs}</Breadcrumbs>
        <PageHeader
          title={m.pages_teams_createteam_title()}
          subTitle={m.pages_teams_createteam_subtitle()}
        >
          <Button
            component={Link}
            to="/teams"
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
            <form.Field
              name="organizationId"
              validators={{
                onBlur: ({ value }: { value: string }) => {
                  const res = teamSchema.shape.organizationId.safeParse(value);
                  return res.success ? undefined : res.error.issues[0]?.message;
                },
              }}
              children={(field) => (
                <Select
                  label={m.entities_organization()}
                  placeholder="Select an organization"
                  data={organizationOptions}
                  value={field.state.value}
                  error={field.state.meta.isTouched && field.state.meta.errors.length > 0 ? field.state.meta.errors[0] : undefined}
                  onBlur={field.handleBlur}
                  onChange={(value) => {
                    field.handleChange(value || '');
                    form.setFieldValue('userIds', []);
                  }}
                  leftSection={<HiOutlineBuildingOffice2 size={16} />}
                />
              )}
            />

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
                  placeholder="Enter team name"
                  value={field.state.value}
                  error={field.state.meta.isTouched && field.state.meta.errors.length > 0 ? field.state.meta.errors[0] : undefined}
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
                  placeholder="What does this team do?"
                  rows={4}
                  value={field.state.value}
                  error={field.state.meta.isTouched && field.state.meta.errors.length > 0 ? field.state.meta.errors[0] : undefined}
                  onBlur={field.handleBlur}
                  onChange={(e) => field.handleChange(e.target.value)}
                />
              )}
            />

            <form.Field
              name="userIds"
              children={(field) => (
                <UserMultiSelect
                  organizationId={organizationId}
                  value={field.state.value}
                  onChange={(values) => field.handleChange(values)}
                  onBlur={field.handleBlur}
                  error={field.state.meta.isTouched && field.state.meta.errors.length > 0 ? field.state.meta.errors[0] : undefined}
                />
              )}
            />

            <Group justify="flex-end" mt="md">
              <form.Subscribe
                selector={(state) => [state.canSubmit, state.isSubmitting]}
                children={([canSubmit, isSubmitting]) => (
                  <Button
                    type="submit"
                    color="appBlue"
                    loading={isSubmitting as boolean}
                    disabled={!canSubmit}
                    leftSection={<HiOutlinePlus />}
                  >
                    {m.common_save()}
                  </Button>
                )}
              />
            </Group>
          </Stack>
        </Card>
      </form>
    </Stack>
  );
}
