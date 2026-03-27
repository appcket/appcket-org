import { createFileRoute, Link } from '@tanstack/react-router';
import {
  Stack,
  Title,
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
import { useGetTeam } from 'src/hooks/useTeams';
import { HiOutlinePencilSquare, HiOutlineUser, HiOutlineChevronLeft } from 'react-icons/hi2';
import * as m from 'src/paraglide/messages';
import { UserAvatar } from 'src/components/UserAvatar';
import { EntityHistory } from 'src/components/EntityHistory';
import { PageHeader } from 'src/components/PageHeader';
import { hasPermission, TeamPermission } from 'src/lib/permissions';
import { Resources } from 'src/hooks/useHistory';

export const Route = createFileRoute('/teams/$teamId/')({
  component: TeamDetail,
});

function TeamDetail() {
  const { teamId } = Route.useParams();
  const context = Route.useRouteContext() as any;
  const { data: team, isLoading, error } = useGetTeam(teamId);

  const user = context?.session?.user;
  const canUpdate = hasPermission(user?.permissions, Resources.Team, TeamPermission.update);
  const canReadHistory = hasPermission(
    user?.permissions,
    Resources.Team,
    TeamPermission.readHistory,
  );

  if (error) {
    return (
      <Card shadow="sm" padding="lg" radius="md" withBorder color="red">
        <Text fw={500}>Error loading team</Text>
        <Text size="sm">
          {error instanceof Error ? error.message : 'An unknown error occurred'}
        </Text>
      </Card>
    );
  }

  const breadcrumbs = [
    { title: m.common_navigation_teams(), to: '/teams' },
    { title: team?.name || '...', to: `/teams/${teamId}` },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

  return (
    <Stack gap="xl" style={{ position: 'relative', minHeight: '400px' }}>
      <Box>
        <Breadcrumbs mb="xs">{breadcrumbs}</Breadcrumbs>
        <PageHeader
          title={isLoading ? '...' : team?.name || m.pages_teams_viewteam_titlefragment()}
          subTitle={m.pages_teams_viewteam_subtitle()}
        >
          <Group>
            <Button
              component={Link}
              to="/teams"
              variant="light"
              color="gray"
              leftSection={<HiOutlineChevronLeft />}
            >
              {m.common_cancel()}
            </Button>
            <Button
              component={Link}
              to="/teams/$teamId/edit"
              params={{ teamId } as any}
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
                    {team?.organization.name}
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
                  <Text mt={4}>{team?.description || '...'}</Text>
                )}
              </div>

              <Divider my="sm" label="Stats" labelPosition="center" />

              <Group grow>
                <Box
                  p="xs"
                  style={{
                    textAlign: 'center',
                    border: '1px solid var(--mantine-color-default-border)',
                    borderRadius: '8px',
                  }}
                >
                  {isLoading ? (
                    <Skeleton height={30} width={40} mx="auto" />
                  ) : (
                    <Text size="xl" fw={700}>
                      {team?.users.length || 0}
                    </Text>
                  )}
                  <Text size="xs" c="dimmed" tt="uppercase">
                    {m.labels_users()}
                  </Text>
                </Box>
              </Group>
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
              ) : team?.users.length === 0 ? (
                <Text size="sm" c="dimmed" ta="center" py="lg">
                  {m.messages_info_nousersassociatedwith()} {m.entities_team()}
                </Text>
              ) : (
                team?.users.map((user: any) => (
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

      {canReadHistory && <EntityHistory entityId={teamId} entityType={Resources.Team} />}
    </Stack>
  );
}
