import { useRef } from 'react';
import { useTranslation } from 'react-i18next';
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
  const { t } = useTranslation();
  const containerRef = useRef(null);
  return (
    <Page title={t('pages.home.title')}>
      <PageHeader title={t('pages.home.title')} subTitle={t('pages.home.subTitle')} />
      <Container maxWidth={false}>
        <Slide direction="up" in={true} container={containerRef.current}>
          <Grid container direction="row" justifyContent="center" alignItems="stretch" spacing={3}>
            <Grid size={{ xs: 12 }}>
              <Card>
                <CardHeader title={t('pages.home.cardTitle')} />
                <CardContent>
                  <Typography variant="subtitle1" component="div">
                    {t('pages.home.body')}
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
