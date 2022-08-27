import { useRef } from 'react';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardHeader from '@mui/material/CardHeader';
import Slide from '@mui/material/Slide';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';

const Home = () => {
  const containerRef = useRef(null);
  return (
    <Page title="Home">
      <PageHeader title="Home" subTitle="Welcome to the Appcket home page" />
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
