import { createFileRoute } from '@tanstack/react-router';
import { Stack, Title, Text, Card } from '@mantine/core';
import * as m from 'src/paraglide/messages';
import { PageHeader } from 'src/components/PageHeader';

export const Route = createFileRoute('/')({
  component: Home,
});

function Home() {
  return (
    <Stack gap="xl">
      <PageHeader 
        title={m.pages_home_title()} 
        subTitle={m.pages_home_subtitle()} 
      />

      <Card shadow="sm" padding="lg" radius="md" withBorder>
        <Card.Section withBorder inheritPadding py="xs">
          <Text fw={500}>{m.pages_home_cardtitle()}</Text>
        </Card.Section>
        <Text mt="md" size="sm">
          {m.pages_home_body()}
        </Text>
      </Card>
    </Stack>
  );
}
