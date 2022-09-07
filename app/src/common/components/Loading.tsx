import CircularProgress from '@mui/material/CircularProgress';
import Container from '@mui/material/Container';

const Loading = () => (
  <Container maxWidth="lg" className="text-center">
    <CircularProgress />
  </Container>
);

export default Loading;
