import Button from '@mui/material/Button';
import PropTypes from 'prop-types';
import UndoIcon from '@mui/icons-material/Undo';

import { Link } from 'react-router-dom';

type Props = {
  variant?: string;
  isDisabled?: boolean;
  linkTo: string;
};

const CancelButton = ({ variant, linkTo, isDisabled }: Props) => {
  return (
    <Button
      variant={variant}
      component={Link}
      to={linkTo}
      disabled={isDisabled}
      startIcon={<UndoIcon />}
    >
      Cancel
    </Button>
  );
};

CancelButton.defaultProps = {
  variant: 'contained',
  linkTo: '',
  isDisabled: false,
};

CancelButton.propTypes = {
  variant: PropTypes.string,
  linkTo: PropTypes.string,
  isDIsabled: PropTypes.bool,
};

export default CancelButton;
