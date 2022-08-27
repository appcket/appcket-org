import React from 'react';
import { Link } from 'react-router-dom';
import Typography from '@mui/material/Typography';

import Page from 'src/common/components/Page';

const NotFound = () => (
  <Page title="404 Error Not Found">
    <Typography variant="h3">Not Found</Typography>
    <Typography variant="body1">
      Oops, we weren't able to find what you were looking for.
    </Typography>
    <Typography variant="body1">
      Try going <Link to="/">home</Link>.
    </Typography>
  </Page>
);

export default NotFound;
