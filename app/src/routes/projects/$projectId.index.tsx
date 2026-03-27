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
  rem,
  Skeleton,
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
import { useGetProject } from 'src/hooks/useProjects';
import { hasPermission, ProjectPermission } from 'src/lib/permissions';

export const Route = createFileRoute('/projects/$projectId/')({
  component: ProjectDetail,
});

function ProjectDetail() {
  const { projectId } = Route.useParams();
  const context = Route.useRouteContext();

  const { data: project, isLoading } = useGetProject(projectId);

  const user = 'session' in context ? context.session?.user : undefined;
  const canUpdate = hasPermission(user?.permissions, Resources.Project, ProjectPermission.update);
  const canReadHistory = hasPermission(
    user?.permissions,
    Resources.Project,
    ProjectPermission.readHistory,
  );

  const breadcrumbs = [
    { title: m.common_navigation_projects(), to: '/projects' },
    {
      title: project?.name || <Skeleton height={16} width={100} display="inline-block" />,
      to: `/projects/${projectId}`,
    },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

  const pageTitle = project?.name || (
    <Skeleton height={rem(34)} width={200} radius="sm" />
  );

  return (
    <Stack gap="xl" style={{ position: 'relative', minHeight: '400px' }}>
      <Box>
        <Breadcrumbs mb="xs">{breadcrumbs}</Breadcrumbs>
        <PageHeader title={pageTitle} subTitle={m.pages_projects_viewproject_subtitle()}>
          <Group>
            <Button
              component={Link}
              to="/projects"
              variant="light"
              color="gray"
              leftSection={<HiOutlineChevronLeft />}
            >
              {m.common_cancel()}
            </Button>
            <Button
              component={Link}
              to="/projects/$projectId/edit"
              params={{ projectId } as any}
              variant="filled"
              color="appBlue"
              leftSection={<HiOutlinePencilSquare />}
              disabled={isLoading || !canUpdate}
            >
              {m.common_edit()}
            </Button>
          </Group>
        </PageHeader>
      </Box>

      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
          gap: '1.5rem',
        }}
      >
        <div style={{ gridColumn: 'span 2' }}>
          <Card shadow="sm" padding="lg" radius="md" withBorder h="100%">
            <Stack gap="md">
              <div>
                <Text size="xs" tt="uppercase" fw={700} c="dimmed">
                  {m.labels_organization()}
                </Text>
                {isLoading ? (
                  <Skeleton height={30} width={150} mt={4} />
                ) : (
                  <Badge size="lg" radius="sm" mt={4} variant="outline">
                    {project?.organization.name}
                  </Badge>
                )}
              </div>

              <div>
                <Text size="xs" tt="uppercase" fw={700} c="dimmed">
                  {m.labels_description()}
                </Text>
                {isLoading ? (
                  <Skeleton height={20} mt={4} />
                ) : (
                  <Text mt={4}>{project?.description || '...'}</Text>
                )}
              </div>

              <Divider my="sm" />

              <Button
                component={Link}
                to="/projects/$projectId/tasks"
                params={{ projectId } as any}
                variant="outline"
                color="appBlue"
                fullWidth
              >
                {m.pages_projects_viewproject_viewtasks()}
              </Button>
            </Stack>
          </Card>
        </div>

        <div>
          <Card shadow="sm" padding="lg" radius="md" withBorder h="100%">
            <Group justify="space-between" mb="md">
              <Text fw={700} size="sm" tt="uppercase">
                {m.labels_users()}
              </Text>
              <HiOutlineUser size={rem(18)} />
            </Group>

            <Stack gap="sm">
              {isLoading ? (
                Array.from({ length: 3 }).map((_, i) => (
                  <Group key={i} wrap="nowrap">
                    <Skeleton circle height={38} />
                    <Box style={{ flex: 1 }}>
                      <Skeleton height={12} width="70%" mb={6} />
                      <Skeleton height={8} width="40%" />
                    </Box>
                  </Group>
                ))
              ) : project?.users.length === 0 ? (
                <Text size="sm" c="dimmed" ta="center" py="lg">
                  {m.messages_info_nousersassociatedwith()} {m.entities_project()}
                </Text>
              ) : (
                project?.users.map((user: any) => (
                  <Group key={user.id} wrap="nowrap">
                    <UserAvatar
                      size="sm"
                      firstName={user.firstName}
                      lastName={user.lastName}
                      username={user.username}
                    />
                    <div style={{ flex: 1 }}>
                      <Text size="sm" fw={500}>
                        {user.firstName} {user.lastName}
                      </Text>
                      <Text size="xs" c="dimmed">
                        {user.attributes?.jobTitle || user.username}
                      </Text>
                    </div>
                  </Group>
                ))
              )}
            </Stack>
          </Card>
        </div>
      </div>

      {canReadHistory && <EntityHistory entityId={projectId} entityType={Resources.Project} />}
    </Stack>
  );
}
