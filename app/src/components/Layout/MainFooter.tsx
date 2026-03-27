import { AppShell, Group, Text, Anchor, rem } from '@mantine/core';

export function MainFooter() {
  return (
    <AppShell.Footer p="md">
      <Group justify="space-between" h="100%">
        <Text size="sm" c="dimmed">
          Copyright © {new Date().getFullYear()}{' '}
          <Anchor href="https://appcket.org" target="_blank" fw={500} underline="hover">
            Appcket
          </Anchor>
          . All rights reserved.
        </Text>
        <Text size="sm" c="dimmed" visibleFrom="xs">
          Crafted with ❤️➕🧠➕🍵
        </Text>
      </Group>
    </AppShell.Footer>
  );
}
