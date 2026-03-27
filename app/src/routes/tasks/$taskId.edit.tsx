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
  Text,
  Select,
  LoadingOverlay,
  Skeleton,
  rem,
} from '@mantine/core';
import { useForm } from '@tanstack/react-form';
import { z } from 'zod';
import { notifications } from '@mantine/notifications';
import { updateTaskAction, useGetTask, useGetTaskStatusTypes } from 'src/hooks/useTasks';
import {
  HiOutlineCheck,
  HiOutlineChevronLeft,
} from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';
import { useEffect } from 'react';
import { PageHeader } from 'src/components/PageHeader';
import { requirePermission, TaskPermission } from 'src/lib/permissions';
import { Resources } from 'src/hooks/useHistory';

export const Route = createFileRoute('/tasks/$taskId/edit')({
  beforeLoad: requirePermission(Resources.Task, TaskPermission.update, '/projects'),
  component: EditTask,
});

const taskSchema = z.object({
  id: z.string(),
  name: z.string().min(2, 'Name must have at least 2 letters'),
  description: z.string().optional(),
  projectId: z.string(),
  taskStatusTypeId: z.string().optional(),
  assignedTo: z.string().optional(),
});

function EditTask() {
  const { taskId } = Route.useParams();
  const navigate = useNavigate();

  const { data: task, isLoading } = useGetTask(taskId);
  const { data: statusTypes } = useGetTaskStatusTypes();

  const form = useForm({
    defaultValues: {
      id: taskId,
      name: task?.name || '',
      description: task?.description || '',
      projectId: task?.project?.id || '',
      taskStatusTypeId: task?.taskStatusType?.id || '',
      assignedTo: task?.assignedTo?.id || '',
    },
    onSubmit: async ({ value }) => {
      try {
        await updateTaskAction({ data: value as any });
        notifications.show({
          title: m.common_updated(),
          message: m.messages_success_teamupdated({ name: value.name }), // Reusing message for now
          color: 'green',
          icon: <HiOutlineCheck />,
        });
        navigate({ to: '/tasks/$taskId', params: { taskId } as any });
      } catch (error) {
        notifications.show({
          title: m.messages_error_error(),
          message: m.messages_error_teamupdatefailed(),
          color: 'red',
        });
      }
    },
  });

  // Sync form if client-side data changes
  useEffect(() => {
    if (task) {
      form.reset({
        id: taskId,
        name: task.name,
        description: task.description || '',
        projectId: task.project.id,
        taskStatusTypeId: task.taskStatusType?.id || '',
        assignedTo: task.assignedTo?.id || '',
      });
    }
  }, [task, form, taskId]);

  const statusOptions = (statusTypes || []).map(s => ({ value: s.id, label: s.name }));
  const userOptions = (task?.project?.users || []).map(u => ({ 
    value: u.id, 
    label: `${u.firstName} ${u.lastName}` 
  }));

  const breadcrumbs = [
    { title: m.common_navigation_projects(), to: '/projects' },
    {
      title: task?.project?.name || <Skeleton height={16} width={100} display="inline-block" />,
      to: task?.project ? `/projects/${task.project.id}` : '/projects',
    },
    {
      title: m.labels_tasks(),
      to: task?.project ? `/projects/${task.project.id}/tasks` : '/projects',
    },
    {
      title: task?.name || <Skeleton height={16} width={100} display="inline-block" />,
      to: `/tasks/${taskId}`,
    },
    { title: m.common_edit(), to: `/tasks/${taskId}/edit` },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

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
          title={task?.name || <Skeleton height={rem(34)} width={250} radius="sm" />}
          subTitle={m.pages_tasks_edittask_subtitle()}
        >
          <Button
            component={Link}
            to="/tasks/$taskId"
            params={{ taskId } as any}
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
            <Box mb="md">
              <Text size="xs" tt="uppercase" fw={700} c="dimmed">{m.entities_project()}</Text>
              {isLoading ? <Skeleton height={20} width={150} /> : <Text fw={500}>{task?.project?.name}</Text>}
            </Box>

            <form.Field
              name="name"
              validators={{
                onBlur: ({ value }: { value: string }) => {
                  const res = taskSchema.shape.name.safeParse(value);
                  return res.success ? undefined : res.error.issues[0]?.message;
                }
              }}
              children={(field) => (
                <TextInput
                  label={m.common_name()}
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
                onBlur: ({ value }: { value: string | undefined }) => {
                  const res = taskSchema.shape.description.safeParse(value);
                  return res.success ? undefined : res.error.issues[0]?.message;
                }
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

            <Group grow>
              <form.Field
                name="taskStatusTypeId"
                children={(field) => (
                  <Select
                    label={m.labels_status()}
                    placeholder="Select status"
                    data={statusOptions}
                    value={field.state.value}
                    onBlur={field.handleBlur}
                    onChange={(value) => field.handleChange(value || '')}
                  />
                )}
              />

              <form.Field
                name="assignedTo"
                children={(field) => (
                  <Select
                    label={m.labels_assignedto()}
                    placeholder="Assign to..."
                    data={userOptions}
                    value={field.state.value}
                    onBlur={field.handleBlur}
                    onChange={(value) => field.handleChange(value || '')}
                    searchable
                  />
                )}
              />
            </Group>

            <Group justify="flex-end" mt="md">
              <form.Subscribe
                selector={(state) => [state.canSubmit, state.isSubmitting, state.isDirty]}
                children={([canSubmit, isSubmitting, isDirty]) => (
                  <Button
                    type="submit"
                    color="appBlue"
                    loading={isSubmitting as boolean}
                    disabled={!canSubmit || !isDirty}
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
