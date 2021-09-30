import React from 'react';
import { Container } from '@material-ui/core';
import Typography from '@material-ui/core/Typography';

import Page from 'src/components/Page';

const AboutPage = () => (
  <Page title="About">
    <Container maxWidth="lg">
      <h1>About</h1>
      <Typography paragraph>
        This is a sample React application which is part of the{' '}
        <a href="https://github.com/appcket/appcket-org">Appcket starter kit</a>
        . It's meant to give developers a foundation to start building a web app
        and also serve as an example of how to authenticate with Keycloak and
        access a protected GraphQL API.
      </Typography>
      <Typography paragraph>
        Please see the <a href="https://appcket.org">Appcket Docs</a> for more
        information.
      </Typography>
    </Container>
  </Page>
);

export default AboutPage;
