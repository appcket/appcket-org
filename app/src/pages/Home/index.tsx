import React from 'react';
import { Container } from '@mui/material';
import Typography from '@mui/material/Typography';

import Page from 'src/components/Page';

const Home = () => (
  <Page title="Home">
    <Container maxWidth="lg">
      <h1>Home</h1>
      <Typography paragraph>
        Edit your homepage contents in src/pages/Home/index.tsx.
      </Typography>
    </Container>
  </Page>
);

export { Home };
