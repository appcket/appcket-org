import React from 'react';
import { Container } from '@mui/material';
import Typography from '@mui/material/Typography';
import { useParams } from 'react-router-dom';

import Page from 'src/components/Page';
import { useTeamById } from 'src/common/api/team';

const Team = () => {
  let params = useParams();

  const { status, data, error } = useTeamById(params.teamId!);

  let teamComponent;

  if (status === 'loading') {
    teamComponent = <Typography paragraph>Loading...</Typography>;
  } else if (status === 'error') {
    teamComponent = (
      // @ts-ignore
      <Typography paragraph>Error: {error.response.error}</Typography>
    );
  } else {
    teamComponent = (
      <div>
        <h1>{data?.name}</h1>
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
