import React from 'react';
import { Link } from 'react-router-dom';
import Typography from '@mui/material/Typography';

import Page from 'src/common/components/Page';

const Unauthorized = () => (
  <Page title="Unauthorized">
    <Typography variant="h3">Sorry ✋</Typography>
    <Typography variant="body1">
      You are do not have access to view this page. Please contact the administrator for more
      information.
    </Typography>
    <Typography variant="body1">
      Try going <Link to="/">home</Link>.
    </Typography>
  </Page>
);

export default Unauthorized;
