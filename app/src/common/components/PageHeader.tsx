import { ReactNode, useRef } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Slide from '@mui/material/Slide';
import PropTypes from 'prop-types';

type Props = { title?: string; subTitle?: string; children?: ReactNode };

const PageHeader = ({ title, subTitle, children }: Props) => {
  const containerRef = useRef(null);
  return (
    <Box
      className="drop-shadow-sm"
      sx={{ bgcolor: 'background.pageHeader', pt: 10, pl: 5, pb: 5, pr: 5, mb: 5 }}
    >
      <Grid container spacing={2} className="pt-16">
        <Grid size={{ xs: 12, sm: 8 }}>
          <Slide direction="right" in={true} container={containerRef.current}>
            <Box>
              <Typography variant="h1" component="h1" gutterBottom>
                {title}
              </Typography>
              <Typography variant="subtitle2">{subTitle}</Typography>
            </Box>
          </Slide>
        </Grid>
        <Grid size={{ xs: 4 }} mt={2}>
          <Slide direction="left" in={true} container={containerRef.current}>
            <Box>{children}</Box>
          </Slide>
        </Grid>
      </Grid>
    </Box>
  );
};

PageHeader.propTypes = {
  title: PropTypes.string,
  subTitle: PropTypes.string,
  children: PropTypes.node,
};

export default PageHeader;
