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
  MultiSelect,
  rem,
} from '@mantine/core';
import { useForm } from '@tanstack/react-form';
import { z } from 'zod';
import { notifications } from '@mantine/notifications';
import { useGetProject, updateProjectAction } from 'src/hooks/useProjects';
import {
  HiOutlineCheck,
  HiOutlineArrowPath,
  HiOutlineChevronLeft,
} from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';
import { useEffect } from 'react';
import { PageHeader } from 'src/components/PageHeader';
import { UserMultiSelect } from 'src/components/Form/UserMultiSelect';
import { requirePermission, ProjectPermission } from 'src/lib/permissions';
import { Resources } from 'src/hooks/useHistory';

export const Route = createFileRoute('/projects/$projectId/edit')({
  beforeLoad: requirePermission(Resources.Project, ProjectPermission.update, '/projects'),
  component: EditProject,
});

const projectSchema = z.object({
  id: z.string(),
  name: z.string().min(2, 'Name must have at least 2 letters'),
  description: z.string().optional(),
  organizationId: z.string().min(1, 'Organization is required'),
  userIds: z.array(z.string()).default([]),
});

function EditProject() {
  const { projectId } = Route.useParams();
  const navigate = useNavigate();

  const { data: project, isLoading: isProjectLoading } = useGetProject(projectId);
  
  const form = useForm({
    defaultValues: {
      id: projectId,
      name: project?.name || '',
      description: project?.description || '',
      organizationId: project?.organization?.id || '',
      userIds: project?.users?.map((u: any) => u.id) || [],
    },
    onSubmit: async ({ value }) => {
      try {
        await updateProjectAction({ data: value as any });
        notifications.show({
          title: m.common_updated(),
          message: m.messages_success_projectupdated({ name: value.name }),
          color: 'green',
          icon: <HiOutlineCheck />,
        });
        navigate({ to: '/projects/$projectId', params: { projectId } as any });
      } catch (error) {
        notifications.show({
          title: m.messages_error_error(),
          message: m.messages_error_projectupdatefailed(),
          color: 'red',
        });
      }
    },
  });

  useEffect(() => {
    if (project) {
      form.reset({
        id: projectId,
        name: project.name,
        description: project.description || '',
        organizationId: project.organization.id,
        userIds: project.users.map((u) => u.id),
      });
    }
  }, [project, form, projectId]);

  const breadcrumbs = [
    { title: m.common_navigation_projects(), to: '/projects' },
    {
      title: project?.name || <Skeleton height={16} width={100} display="inline-block" />,
      to: `/projects/${projectId}`,
    },
    { title: m.common_edit(), to: `/projects/${projectId}/edit` },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

  const isLoading = isProjectLoading;

  const pageTitle = isLoading ? (
    <Skeleton height={rem(34)} width={300} radius="sm" />
  ) : (
    `${m.pages_projects_editproject_titlefragment()}: ${project?.name}`
  );

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
          subTitle={m.pages_projects_editproject_subtitle()}
        >
          <Button
            component={Link}
            to="/projects/$projectId"
            params={{ projectId } as any}
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
                <Skeleton height={20} width={150} mb="md" />
                <Skeleton height={40} mb="md" />
                <Skeleton height={100} mb="md" />
                <Skeleton height={40} />
              </>
            ) : (
              <>
                <Box mb="md">
                  <Text size="xs" tt="uppercase" fw={700} c="dimmed">
                    {m.labels_organization()}
                  </Text>
                  <Text fw={500}>{project?.organization?.name}</Text>
                </Box>

                <form.Field
                  name="name"
                  validators={{
                    onBlur: ({ value }) => {
                      const res = projectSchema.shape.name.safeParse(value);
                      return res.success ? undefined : res.error.issues[0]?.message;
                    },
                  }}
                  children={(field) => (
                    <TextInput
                      label={m.labels_projectname()}
                      placeholder="..."
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
                    onBlur: ({ value }) => {
                      const res = projectSchema.shape.description.safeParse(value);
                      return res.success ? undefined : res.error.issues[0]?.message;
                    },
                  }}
                  children={(field) => (
                    <Textarea
                      label={m.labels_description()}
                      placeholder="..."
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
                      organizationId={project?.organization?.id || ''}
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
