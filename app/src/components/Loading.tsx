import React from 'react';
import { CircularProgress, Container } from '@material-ui/core';

const Loading = () => {
  return (
    <Container maxWidth="lg">
      <CircularProgress />
    </Container>
  );
};

export default Loading;
