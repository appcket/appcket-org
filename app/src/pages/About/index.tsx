import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid2';
import Fade from '@mui/material/Fade';
import Link from '@mui/material/Link';
import { useTranslation } from 'react-i18next';

import Page from 'src/common/components/Page';
import PageHeader from 'src/common/components/PageHeader';

const About = () => {
  const { t } = useTranslation();

  return (
    <Page title={t('pages.about.title')}>
      <PageHeader title={t('pages.about.title')} subTitle={t('pages.about.subTitle')} />
      <Container maxWidth={false}>
        <Fade
          in={true}
          easing={{
            enter: 'cubic-bezier(0.4, 0, 0.7, 1)',
          }}
        >
          <Grid container direction="row" justifyContent="center" alignItems="stretch" spacing={3}>
            <Grid size={{ xs: 12 }}>
              <Typography component="p">
                This is a sample React application which is part of the{' '}
                <Link href="https://github.com/appcket/appcket-org">Appcket starter kit</Link>.
                It&apos;s meant to give developers a foundation to start building a web app while
                serving as an example of how to authenticate and authorize with Keycloak and access
                a protected GraphQL API.
              </Typography>
              <Typography component="p">
                Check out the <Link href="https://appcket.org">Appcket Docs</Link> for more
                information.
              </Typography>
            </Grid>
          </Grid>
        </Fade>
      </Container>
    </Page>
  );
};

export default About;
