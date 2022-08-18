import { useRef } from 'react';
import Container from '@mui/material/Container';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Slide from '@mui/material/Slide';
import Fade from '@mui/material/Fade';

import Page from 'src/common/components/Page';

const About = () => {
  const containerRef = useRef(null);
  return (
    <Page title="About">
      <Container maxWidth={false} className="mb-10 py-10 shadow-sm bg-white/70">
        <Grid container justifyContent="space-between" alignItems="center">
          <Grid item>
            <Slide direction="right" in={true} container={containerRef.current}>
              <Box>
                <Typography variant="h1" component="h1" gutterBottom>
                  About
                </Typography>
                <Typography variant="subtitle2">Learn about the Appcket starter kit</Typography>
              </Box>
            </Slide>
          </Grid>
        </Grid>
      </Container>
      <Container maxWidth={false}>
        <Fade
          in={true}
          easing={{
            enter: 'cubic-bezier(0.4, 0, 0.7, 1)',
          }}
        >
          <Grid container direction="row" justifyContent="center" alignItems="stretch" spacing={3}>
            <Grid item xs={12}>
              <Typography paragraph>
                This is a sample React application which is part of the{' '}
                <a href="https://github.com/appcket/appcket-org">Appcket starter kit</a>. It&apos;s
                meant to give developers a foundation to start building a web app while serving as
                an example of how to authenticate and authorize with Keycloak and access a protected
                GraphQL API.
              </Typography>
              <Typography paragraph>
                Check out the <a href="https://appcket.org">Appcket Docs</a> for more information.
              </Typography>
            </Grid>
          </Grid>
        </Fade>
      </Container>
    </Page>
  );
};

export default About;
