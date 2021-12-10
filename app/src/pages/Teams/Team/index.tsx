import React from 'react';
import { useParams } from 'react-router-dom';
import Container from '@mui/material/Container';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';

import Page from 'src/components/Page';
import { useTeamById } from 'src/common/api/team';

const Team = () => {
  let params = useParams();

  const { status, data, error } = useTeamById(params.teamId!);

  let teamComponent;

  if (status === 'loading') {
    teamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error' && error instanceof Error) {
    teamComponent = <Typography paragraph>Error: {error.message}</Typography>;
  } else {
    teamComponent = (
      <div>
        <Typography variant="h4" gutterBottom>
          {data?.name}
        </Typography>

        <Paper elevation={1} sx={{ my: { xs: 3, md: 6 }, p: { xs: 2, md: 3 } }}>
          <Grid item xs={12} sm={6}>
            <TextField required id="name" name="name" label="Name" fullWidth variant="outlined" />
          </Grid>
        </Paper>
      </div>
    );
  }

  return (
    <Page title="Team">
      <Container maxWidth="lg">
        <div>{teamComponent}</div>
      </Container>
    </Page>
  );
};

export default Team;
