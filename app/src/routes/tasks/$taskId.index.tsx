import { createFileRoute, Link } from '@tanstack/react-router';
import {
  Stack,
  Text,
  Card,
  Group,
  Button,
  Badge,
  Divider,
  Box,
  Breadcrumbs,
  Anchor,
  Skeleton,
  rem,
} from '@mantine/core';
import {
  HiOutlinePencilSquare,
  HiOutlineChevronLeft,
  HiOutlineBriefcase,
  HiOutlineUser,
} from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';
import { UserAvatar } from 'src/components/UserAvatar';
import { EntityHistory } from 'src/components/EntityHistory';
import { PageHeader } from 'src/components/PageHeader';
import { Resources } from 'src/hooks/useHistory';
import { useGetTask } from 'src/hooks/useTasks';
import { hasPermission, TaskPermission } from 'src/lib/permissions';

export const Route = createFileRoute('/tasks/$taskId/')({
  component: TaskDetail,
});

function TaskDetail() {
  const { taskId } = Route.useParams();
  const context = Route.useRouteContext();
  const { data: task } = useGetTask(taskId);

  const user = 'session' in context ? context.session?.user : undefined;
  const canUpdate = hasPermission(user?.permissions, Resources.Task, TaskPermission.update);
  const canReadHistory = hasPermission(
    user?.permissions,
    Resources.Task,
    TaskPermission.readHistory,
  );

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
          title={task?.name || <Skeleton height={rem(34)} width={250} radius="sm" />}
          subTitle={m.pages_tasks_viewtask_subtitle()}
        >
          <Group>
            <Button
              component={Link}
              to="/projects/$projectId/tasks"
              params={{ projectId: task?.project?.id || '' } as any}
              variant="light"
              color="gray"
              leftSection={<HiOutlineChevronLeft />}
              disabled={!task?.project}
            >
              {m.common_cancel()}
            </Button>
            <Button
              component={Link}
              to="/tasks/$taskId/edit"
              params={{ taskId } as any}
              variant="filled"
              color="appBlue"
              leftSection={<HiOutlinePencilSquare />}
              disabled={!canUpdate}
            >
              {m.common_edit()}
            </Button>
          </Group>
        </PageHeader>
      </Box>

      <Card shadow="sm" padding="lg" radius="md" withBorder>
        <Stack gap="md">
          <div>
            <Text size="xs" tt="uppercase" fw={700} c="dimmed">
              {m.entities_project()}
            </Text>
            {task?.project ? (
              <Anchor
                component={Link}
                to="/projects/$projectId"
                params={{ projectId: task.project.id } as any}
                fw={500}
              >
                {task.project.name}
              </Anchor>
            ) : (
              <Text fw={500}>...</Text>
            )}
          </div>

          <Group grow>
            <div>
              <Text size="xs" tt="uppercase" fw={700} c="dimmed">
                {m.labels_status()}
              </Text>
              <Badge size="lg" radius="sm" mt={4} color="appBlue" variant="light">
                {task?.taskStatusType?.name || 'Status Not Set'}
              </Badge>
            </div>

            <div>
              <Text size="xs" tt="uppercase" fw={700} c="dimmed">
                {m.labels_assignedto()}
              </Text>
              {task?.assignedTo ? (
                <Group gap="xs" mt={4}>
                  <UserAvatar
                    size="xs"
                    firstName={task.assignedTo.firstName}
                    lastName={task.assignedTo.lastName}
                    username={task.assignedTo.username}
                  />
                  <Text size="sm" fw={500}>
                    {task.assignedTo.firstName} {task.assignedTo.lastName}
                  </Text>
                </Group>
              ) : (
                <Text size="sm" c="dimmed">
                  Unassigned
                </Text>
              )}
            </div>
          </Group>

          <Divider />

          <div>
            <Text size="xs" tt="uppercase" fw={700} c="dimmed">
              {m.labels_description()}
            </Text>
            <Text mt={4}>{task?.description || '...'}</Text>
          </div>
        </Stack>
      </Card>

      {canReadHistory && <EntityHistory entityId={taskId} entityType={Resources.Task} />}
    </Stack>
  );
}
