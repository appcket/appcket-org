import React from 'react';
import { useParams } from 'react-router-dom';
import Container from '@mui/material/Container';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';

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
        <h1>{data?.name}</h1>

        <Paper elevation={1} sx={{ my: { xs: 3, md: 6 }, p: { xs: 2, md: 3 } }}>
          <p>Team Form here</p>
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
