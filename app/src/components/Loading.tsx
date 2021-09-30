import React from 'react';
import { CircularProgress, Container } from '@material-ui/core';

const Loading = () => (
  <Container maxWidth="lg">
    <CircularProgress />
  </Container>
);

export default Loading;
