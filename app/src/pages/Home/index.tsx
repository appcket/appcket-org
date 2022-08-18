import { useRef } from 'react';
import Container from '@mui/material/Container';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardHeader from '@mui/material/CardHeader';
import Slide from '@mui/material/Slide';

import Page from 'src/common/components/Page';

const Home = () => {
  const containerRef = useRef(null);
  return (
    <Page title="Home">
      <Container maxWidth={false} className="mb-10 py-10 shadow-sm bg-white/70">
        <Grid container justifyContent="space-between" alignItems="center">
          <Grid item>
            <Slide direction="right" in={true} container={containerRef.current}>
              <Box>
                <Typography variant="h1" component="h1" gutterBottom>
                  Home
                </Typography>
                <Typography variant="subtitle2">Welcome to the Appcket home page</Typography>
              </Box>
            </Slide>
          </Grid>
        </Grid>
      </Container>
      <Container maxWidth={false}>
        <Slide direction="up" in={true} container={containerRef.current}>
          <Grid container direction="row" justifyContent="center" alignItems="stretch" spacing={3}>
            <Grid item xs={12}>
              <Card>
                <CardHeader title="Home Card" />
                <CardContent>
                  <Typography variant="subtitle1" component="div">
                    Edit your homepage contents in src/pages/Home/index.tsx.
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          </Grid>
        </Slide>
      </Container>
    </Page>
  );
};

export default Home;
