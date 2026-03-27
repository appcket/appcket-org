import { createFileRoute, redirect, useNavigate, Link } from '@tanstack/react-router';
import {
  Stack,
  Text,
  Card,
  Table,
  Group,
  TextInput,
  Button,
  Badge,
  rem,
  Box,
  Skeleton,
  Anchor,
  Breadcrumbs,
} from '@mantine/core';
import { z } from 'zod';
import { useSearchTasks, Task } from 'src/hooks/useTasks';
import { useGetProject } from 'src/hooks/useProjects';
import { useMemo, useState } from 'react';
import * as m from 'src/paraglide/messages';
import { formatDate, formatDateTime } from 'src/lib/i18n';
import { PageHeader } from 'src/components/PageHeader';
import {
  useReactTable,
  getCoreRowModel,
  flexRender,
  createColumnHelper,
} from '@tanstack/react-table';
import {
  HiOutlineChevronUpDown,
  HiOutlineChevronUp,
  HiOutlineChevronDown,
  HiOutlineMagnifyingGlass,
  HiOutlinePlus,
} from 'react-icons/hi2';
import { keepPreviousData } from '@tanstack/react-query';
import { hasPermission, TaskPermission } from 'src/lib/permissions';
import { Resources } from 'src/hooks/useHistory';

const tasksSearchSchema = z.object({
  page: z.number().optional(),
  pageSize: z.number().optional(),
  search: z.string().optional(),
  orderBy: z.string().optional(),
  orderDirection: z.enum(['ASC', 'DESC']).optional(),
  cursor: z.string().optional(),
});

export const Route = createFileRoute('/projects/$projectId/tasks')({
  validateSearch: (search) => tasksSearchSchema.parse(search),
  beforeLoad: ({ search }) => {
    if (!search.page || !search.pageSize || search.search === undefined) {
      throw redirect({
        to: '.',
        search: (prev) => ({
          ...prev,
          page: 1,
          pageSize: 10,
          search: '',
          orderBy: 'name',
          orderDirection: 'ASC',
        }),
        replace: true,
      });
    }
  },
  component: ProjectTasks,
});

const columnHelper = createColumnHelper<Task>();

function ProjectTasks() {
  const { projectId } = Route.useParams();
  const search = Route.useSearch();
  const navigate = useNavigate({ from: Route.fullPath });
  const context = Route.useRouteContext();
  const [searchValue, setSearchValue] = useState(search.search || '');

  const { data: project } = useGetProject(projectId);

  const user = context?.session?.user;
  const canCreate = hasPermission(user?.permissions, Resources.Task, TaskPermission.create);

  const page = search.page || 1;
  const pageSize = search.pageSize || 10;
  const orderBy = search.orderBy || 'name';
  const orderDirection = search.orderDirection || 'ASC';

  const { data, isLoading, isFetching, isPlaceholderData } = useSearchTasks(
    [projectId],
    search.search || '',
    pageSize,
    search.cursor || null,
    [{ fieldName: orderBy, direction: orderDirection as 'ASC' | 'DESC' }],
    keepPreviousData,
  );

  const showSkeletons = isFetching && (isLoading || isPlaceholderData);

  const columns = useMemo(
    () => [
      columnHelper.accessor('name', {
        header: m.common_name(),
        cell: (info) => (
          <Text
            component={Link}
            to="/tasks/$taskId"
            params={{ taskId: info.row.original.id } as any}
            fw={500}
            size="sm"
            c="appBlue"
            style={{ cursor: 'pointer', textDecoration: 'none' }}
          >
            {info.getValue()}
          </Text>
        ),
      }),
      columnHelper.accessor('assignedTo', {
        header: m.labels_assignedto(),
        cell: (info) => {
          const val = info.getValue();
          return val ? `${val.firstName} ${val.lastName}` : '-';
        },
      }),
      columnHelper.accessor('taskStatusType.name', {
        header: m.labels_status(),
        cell: (info) => <Badge variant="light">{info.getValue()}</Badge>,
      }),
      columnHelper.accessor('updatedAt', {
        header: m.common_updated(),
        cell: (info) => formatDateTime(info.getValue()),
      }),
      columnHelper.accessor('createdAt', {
        header: m.common_created(),
        cell: (info) => formatDate(info.getValue()),
      }),
    ],
    [],
  );

  const tableData = useMemo(() => data?.edges.map((e) => e.node) || [], [data]);

  const table = useReactTable({
    data: tableData,
    columns,
    getCoreRowModel: getCoreRowModel(),
    manualSorting: true,
    state: {
      sorting: [{ id: orderBy, desc: orderDirection === 'DESC' }],
    },
  });

  const handleSearch = () => {
    navigate({
      search: (prev) => ({ ...prev, search: searchValue, page: 1, cursor: undefined }),
    });
  };

  const toggleSort = (field: string) => {
    const isDesc = orderBy === field && orderDirection === 'ASC';
    navigate({
      search: (prev) => ({
        ...prev,
        orderBy: field,
        orderDirection: isDesc ? 'DESC' : 'ASC',
        page: 1,
        cursor: undefined,
      }),
    });
  };

  const handleNextPage = () => {
    if (data?.pageInfo.hasNextPage) {
      navigate({
        search: (prev) => ({
          ...prev,
          page: (prev.page || 1) + 1,
          cursor: data.pageInfo.endCursor,
        }),
      });
    }
  };

  const handlePrevPage = () => {
    if (data?.pageInfo.hasPreviousPage) {
      navigate({
        search: (prev) => ({
          ...prev,
          page: Math.max((prev.page || 1) - 1, 1),
          cursor: data.pageInfo.startCursor,
        }),
      });
    }
  };

  const breadcrumbs = [
    { title: m.common_navigation_projects(), to: '/projects' },
    {
      title: project?.name || <Skeleton height={16} width={100} display="inline-block" />,
      to: `/projects/${projectId}`,
    },
    { title: m.labels_tasks(), to: `/projects/${projectId}/tasks` },
  ].map((item, index) => (
    <Anchor component={Link} to={item.to} key={index} size="sm">
      {item.title}
    </Anchor>
  ));

  const pageTitle = project?.name ? (
    `${project.name} ${m.labels_tasks()}`
  ) : (
    <Skeleton height={rem(34)} width={250} radius="sm" />
  );

  return (
    <Stack gap="xl">
      <Box>
        <Breadcrumbs mb="xs">{breadcrumbs}</Breadcrumbs>
        <PageHeader title={pageTitle} subTitle={m.pages_tasks_viewprojecttasks_subtitle()}>
          <Button
            component={Link}
            to="/tasks/create"
            search={{ projectId } as any}
            leftSection={<HiOutlinePlus />}
            color="appBlue"
            disabled={!canCreate}
          >
            {m.pages_tasks_viewprojecttasks_createteam()}
          </Button>
        </PageHeader>
      </Box>

      <Card shadow="sm" radius="md" withBorder p={0}>
        <Box p="md" style={{ borderBottom: '1px solid var(--mantine-color-default-border)' }}>
          <Group>
            <TextInput
              placeholder="Search tasks..."
              leftSection={<HiOutlineMagnifyingGlass size={rem(16)} />}
              value={searchValue}
              onChange={(e) => setSearchValue(e.currentTarget.value)}
              onKeyDown={(e) => e.key === 'Enter' && handleSearch()}
              style={{ flex: 1 }}
            />
            <Button variant="light" color="appBlue" onClick={handleSearch}>
              Search
            </Button>
          </Group>
        </Box>

        <Box style={{ position: 'relative', overflow: 'hidden' }}>
          <Table
            verticalSpacing="sm"
            highlightOnHover
            style={{ tableLayout: 'fixed', width: '100%' }}
          >
            <Table.Thead>
              {table.getHeaderGroups().map((headerGroup) => (
                <Table.Tr key={headerGroup.id}>
                  {headerGroup.headers.map((header) => {
                    const canSort = true;
                    return (
                      <Table.Th key={header.id} style={{ width: header.getSize() }}>
                        {header.isPlaceholder ? null : (
                          <Group
                            gap="xs"
                            style={{ cursor: canSort ? 'pointer' : 'default' }}
                            onClick={() => canSort && toggleSort(header.column.id)}
                          >
                            <Text size="xs" fw={700}>
                              {flexRender(header.column.columnDef.header, header.getContext())}
                            </Text>
                            {canSort && (
                              <Box style={{ display: 'flex' }}>
                                {orderBy !== header.column.id ? (
                                  <HiOutlineChevronUpDown size={rem(14)} />
                                ) : orderDirection === 'ASC' ? (
                                  <HiOutlineChevronUp
                                    size={rem(14)}
                                    color="var(--mantine-color-appBlue-6)"
                                  />
                                ) : (
                                  <HiOutlineChevronDown
                                    size={rem(14)}
                                    color="var(--mantine-color-appBlue-6)"
                                  />
                                )}
                              </Box>
                            )}
                          </Group>
                        )}
                      </Table.Th>
                    );
                  })}
                </Table.Tr>
              ))}
            </Table.Thead>
            <Table.Tbody>
              {showSkeletons ? (
                Array.from({ length: pageSize }).map((_, index) => (
                  <Table.Tr key={index} style={{ height: rem(51) }}>
                    <Table.Td>
                      <Skeleton height={20} radius="sm" width="80%" />
                    </Table.Td>
                    <Table.Td>
                      <Skeleton height={20} radius="sm" width="60%" />
                    </Table.Td>
                    <Table.Td>
                      <Skeleton height={20} radius="sm" width="50%" />
                    </Table.Td>
                    <Table.Td>
                      <Skeleton height={20} radius="sm" width="50%" />
                    </Table.Td>
                    <Table.Td>
                      <Skeleton height={20} radius="sm" width="50%" />
                    </Table.Td>
                  </Table.Tr>
                ))
              ) : table.getRowModel().rows.length > 0 ? (
                table.getRowModel().rows.map((row) => (
                  <Table.Tr key={row.id}>
                    {row.getVisibleCells().map((cell) => (
                      <Table.Td key={cell.id} style={{ width: cell.column.getSize() }}>
                        {flexRender(cell.column.columnDef.cell, cell.getContext())}
                      </Table.Td>
                    ))}
                  </Table.Tr>
                ))
              ) : (
                <Table.Tr>
                  <Table.Td colSpan={columns.length}>
                    <Text ta="center" py="xl" c="dimmed">
                      No tasks found for this project.
                    </Text>
                  </Table.Td>
                </Table.Tr>
              )}
            </Table.Tbody>
          </Table>
        </Box>

        <Box p="md" style={{ borderTop: '1px solid var(--mantine-color-default-border)' }}>
          <Group justify="space-between">
            <Text size="sm" c="dimmed">
              Showing {tableData.length} of {data?.totalCount || 0} tasks
            </Text>
            <Group gap="xs">
              <Button
                variant="default"
                size="xs"
                disabled={!data?.pageInfo.hasPreviousPage}
                onClick={handlePrevPage}
              >
                Previous
              </Button>
              <Badge variant="light" size="lg" radius="sm" color="appBlue">
                Page {page}
              </Badge>
              <Button
                variant="default"
                size="xs"
                disabled={!data?.pageInfo.hasNextPage}
                onClick={handleNextPage}
              >
                Next
              </Button>
            </Group>
          </Group>
        </Box>
      </Card>
    </Stack>
  );
}
