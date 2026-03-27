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
  Skeleton,
} from '@mantine/core';
import { useForm } from '@tanstack/react-form';
import { z } from 'zod';
import { notifications } from '@mantine/notifications';
import { createTaskAction, useGetTaskStatusTypes } from 'src/hooks/useTasks';
import { useGetProject } from 'src/hooks/useProjects';
import { 
  HiOutlineCheck, 
  HiOutlineChevronLeft,
  HiOutlinePlus,
} from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';
import { PageHeader } from 'src/components/PageHeader';
import { requirePermission, TaskPermission } from 'src/lib/permissions';
import { Resources } from 'src/hooks/useHistory';

const createTaskSearchSchema = z.object({
  projectId: z.string(),
});

export const Route = createFileRoute('/tasks/create')({
  beforeLoad: requirePermission(Resources.Task, TaskPermission.create, '/projects'),
  validateSearch: (search) => createTaskSearchSchema.parse(search),
  component: CreateTask,
});

const taskSchema = z.object({
  name: z.string().min(2, 'Name must have at least 2 letters'),
  description: z.string().optional(),
  projectId: z.string().min(1),
  taskStatusTypeId: z.string().optional(),
  assignedTo: z.string().optional(),
});

function CreateTask() {
  const navigate = useNavigate();
  const { projectId } = Route.useSearch();
  const { data: project, isLoading } = useGetProject(projectId);
  const { data: statusTypes } = useGetTaskStatusTypes();

  const form = useForm({
    defaultValues: {
      name: '',
      description: '',
      projectId: projectId,
      taskStatusTypeId: '',
      assignedTo: '',
    },
    onSubmit: async ({ value }) => {
      try {
        const result = await createTaskAction({ data: value as any });
        notifications.show({
          title: m.common_created(),
          message: m.messages_success_taskcreated({ name: result.name }),
          color: 'green',
          icon: <HiOutlineCheck />,
        });
        navigate({ to: '/tasks/$taskId', params: { taskId: result.id } as any });
      } catch (error) {
        notifications.show({
          title: m.messages_error_error(),
          message: m.messages_error_taskcreatefailed(),
          color: 'red',
        });
      }
    },
  });

  const statusOptions = (statusTypes || []).map(s => ({ value: s.id, label: s.name }));
  const userOptions = (project?.users || []).map(u => ({ 
    value: u.id, 
    label: `${u.firstName} ${u.lastName}` 
  }));

  const breadcrumbs = [
    { title: m.common_navigation_projects(), to: '/projects' },
    {
      title: project?.name || <Skeleton height={16} width={100} display="inline-block" />,
      to: `/projects/${projectId}`,
    },
    { title: m.labels_tasks(), to: `/projects/${projectId}/tasks` },
    { title: m.common_created(), to: `/tasks/create`, search: { projectId } as any },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} search={item.search} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

  return (
    <Stack gap="xl">
      <Box>
        <Breadcrumbs mb="xs">{breadcrumbs}</Breadcrumbs>
        <PageHeader
          title={m.pages_tasks_createtask_title()}
          subTitle={m.pages_tasks_createtask_subtitle()}
        >
          <Button 
            component={Link} 
            to="/projects/$projectId/tasks"
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
            <Box mb="md">
              <Text size="xs" tt="uppercase" fw={700} c="dimmed">{m.entities_project()}</Text>
              {isLoading ? <Skeleton height={20} width={150} /> : <Text fw={500}>{project?.name}</Text>}
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
                  placeholder="Enter task name"
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
