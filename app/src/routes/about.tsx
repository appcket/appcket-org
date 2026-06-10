import { createFileRoute } from '@tanstack/react-router';
import { Stack, Text, Card, Anchor, Breadcrumbs, Box } from '@mantine/core';
import { PageHeader } from 'src/components/PageHeader';
import * as m from 'src/paraglide/messages';

export const Route = createFileRoute('/about')({
  component: About,
});

function About() {
  const p1Placeholder = '{link}';
  const p1Parts = m.pages_about_body_p1({ link: p1Placeholder }).split(p1Placeholder);

  const p2Placeholder = '{link}';
  const p2Parts = m.pages_about_body_p2({ link: p2Placeholder }).split(p2Placeholder);

  return (
    <Stack gap="xl">
      <Box>
        <PageHeader title={m.pages_about_title()} subTitle={m.pages_about_subtitle()} />
      </Box>

      <Card shadow="sm" padding="xl" radius="md" withBorder>
        <Stack gap="md">
          <Text>
            {p1Parts[0]}
            <Anchor href="https://github.com/appcket/appcket-org" target="_blank">
              {m.common_appcket_starter_kit()}
            </Anchor>
            {p1Parts[1]}
          </Text>

          <Text>
            {p2Parts[0]}
            <Anchor href="https://appcket.org" target="_blank">
              {m.common_appcket_docs()}
            </Anchor>
            {p2Parts[1]}
          </Text>
        </Stack>
      </Card>
    </Stack>
  );
}
