import { ReactNode } from 'react';
import {
  Stack,
  Text,
  Timeline,
  Accordion,
  Group,
  Code,
  Box,
  LoadingOverlay,
  rem,
} from '@mantine/core';
import { HiOutlineClock } from 'react-icons/hi2';
import { MdHistory } from 'react-icons/md';
import { useGetEntityHistory, Resources, IEntityHistoryChange } from 'src/hooks/useHistory';
import dayjs from 'dayjs';

interface EntityHistoryProps {
  entityId: string;
  entityType: Resources;
}

function isJson(str: string | null) {
  if (!str) return false;
  try {
    const parsed = JSON.parse(str);
    return typeof parsed === 'object' && parsed !== null;
  } catch (e) {
    return false;
  }
}

export function EntityHistory({ entityId, entityType }: EntityHistoryProps) {
  const { data, isLoading, error } = useGetEntityHistory(entityId, entityType);

  const renderChangeValue = (value: string | null) => {
    if (!value)
      return (
        <Text size="sm" c="dimmed">
          null
        </Text>
      );
    if (isJson(value)) {
      return (
        <Code block style={{ maxHeight: rem(200), overflow: 'auto' }}>
          {JSON.stringify(JSON.parse(value), null, 2)}
        </Code>
      );
    }
    return <Text size="sm">{value}</Text>;
  };

  const renderChange = (change: IEntityHistoryChange): ReactNode => {
    // 1. Creation event (fieldName is null and oldValue is null)
    if (change.fieldName === null && change.oldValue === null) {
      return (
        <Stack gap="xs">
          <Text size="sm" fw={700}>
            {change.changedBy.displayName}
          </Text>
          <Text size="xs" c="dimmed">
            created a new {entityType.toLowerCase()}:
          </Text>
          {renderChangeValue(change.newValue)}
        </Stack>
      );
    }

    // 2. Deletion event (fieldName is null and oldValue exists)
    if (change.fieldName === null && change.oldValue !== null) {
      return (
        <Stack gap="xs">
          <Text size="sm" fw={700}>
            {change.changedBy.displayName}
          </Text>
          <Text size="xs" c="dimmed">
            deleted this {entityType.toLowerCase()}
          </Text>
        </Stack>
      );
    }

    // 3. Update event
    return (
      <Stack gap="xs">
        <Text size="sm" fw={700}>
          {change.changedBy.displayName}
        </Text>
        <Text size="xs" c="dimmed">
          updated field:{' '}
          <Text span fw={700} c="appBlue">
            {change.fieldName}
          </Text>
        </Text>
        <Group grow align="start">
          <Box>
            <Text size="xs" fw={700} tt="uppercase" c="dimmed">
              From
            </Text>
            {renderChangeValue(change.oldValue)}
          </Box>
          <Box>
            <Text size="xs" fw={700} tt="uppercase" c="dimmed">
              To
            </Text>
            {renderChangeValue(change.newValue)}
          </Box>
        </Group>
      </Stack>
    );
  };

  return (
    <Accordion variant="separated" radius="md" mt="xl">
      <Accordion.Item value="history">
        <Accordion.Control
          icon={<MdHistory size={rem(20)} color="var(--mantine-color-appBlue-6)" />}
        >
          <Text fw={500}>History</Text>
        </Accordion.Control>
        <Accordion.Panel style={{ position: 'relative', minHeight: rem(100) }}>
          <LoadingOverlay visible={isLoading} overlayProps={{ blur: 2 }} />

          {error ? (
            <Text c="red" size="sm">
              Error loading history: {error instanceof Error ? error.message : 'Unknown error'}
            </Text>
          ) : data?.changes.length === 0 ? (
            <Text size="sm" c="dimmed" ta="center" py="xl">
              No history found for this {entityType.toLowerCase()}.
            </Text>
          ) : (
            <Timeline active={data?.changes.length} bulletSize={24} lineWidth={2} mt="md">
              {data?.changes.map((change, index) => (
                <Timeline.Item
                  key={index}
                  bullet={<HiOutlineClock size={rem(12)} />}
                  title={
                    <Text size="xs" c="dimmed">
                      {dayjs(change.changedAt).format('MMM D, YYYY HH:mm:ss')}
                    </Text>
                  }
                  styles={{
                    itemBody: {
                      backgroundColor:
                        index % 2 !== 0
                          ? 'light-dark(var(--mantine-color-gray-0), var(--mantine-color-dark-6))'
                          : 'transparent',
                      padding: rem(12),
                      borderRadius: rem(8),
                    },
                  }}
                >
                  <Box mt="xs">{renderChange(change)}</Box>
                </Timeline.Item>
              ))}
            </Timeline>
          )}
        </Accordion.Panel>
      </Accordion.Item>
    </Accordion>
  );
}
