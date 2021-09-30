import React from 'react';
import { Container } from '@material-ui/core';
import Typography from '@material-ui/core/Typography';

import Page from 'src/components/Page';

const HomePage = () => (
  <Page title="Home">
    <Container maxWidth="lg">
      <h1>Home</h1>
      <Typography paragraph>
        Edit your homepage contents in src/pages/HomePage/index.tsx.
      </Typography>
    </Container>
  </Page>
);

export default HomePage;
