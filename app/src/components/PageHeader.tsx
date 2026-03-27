import { ReactNode } from 'react';
import { Title, Text, Group, Box, Stack, rem } from '@mantine/core';

interface PageHeaderProps {
  title: ReactNode;
  subTitle?: string;
  children?: ReactNode;
}

export function PageHeader({ title, subTitle, children }: PageHeaderProps) {
  return (
    <header style={{ marginBottom: '2rem', minHeight: rem(70) }}>
      <Group justify="space-between" align="flex-end" wrap="nowrap">
        <Stack gap={0} style={{ flex: 1 }}>
          {typeof title === 'string' ? (
            <Title order={2} style={{ whiteSpace: 'nowrap' }}>
              {title}
            </Title>
          ) : (
            title
          )}
          {subTitle && (
            <Text c="dimmed" size="sm" style={{ whiteSpace: 'nowrap' }}>
              {subTitle}
            </Text>
          )}
        </Stack>

        {children && <Box>{children}</Box>}
      </Group>
    </header>
  );
}
