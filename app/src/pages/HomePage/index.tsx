import React from 'react';
import { Container } from '@material-ui/core';

import Page from 'src/components/Page';

const HomePage = () => {
  return (
    <Page title="Home">
      <Container maxWidth="lg">
        <h1>Home</h1>
      </Container>
    </Page>
  );
};

export default HomePage;
