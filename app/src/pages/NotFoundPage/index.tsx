import React from 'react';
import { Link } from 'react-router-dom';
import { Container } from '@mui/material';

import Page from 'src/components/Page';

const NotFoundPage = () => (
  <Page title="404 Error Not Found">
    <Container maxWidth="lg">
      <h1>Not Found</h1>
      <p>Oops, we weren't able to find what you were looking for.</p>
      <p>
        Try going <Link to="/">home</Link>.
      </p>
    </Container>
  </Page>
);

export default NotFoundPage;
