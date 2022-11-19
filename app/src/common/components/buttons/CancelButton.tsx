import Button, { ButtonPropsVariantOverrides } from '@mui/material/Button';
import { OverridableStringUnion } from '@mui/types';
import PropTypes from 'prop-types';
import UndoIcon from '@mui/icons-material/Undo';

import { Link } from 'react-router-dom';

type Props = {
  variant?: OverridableStringUnion<'text' | 'outlined' | 'contained', ButtonPropsVariantOverrides>;
  isDisabled?: boolean;
  linkTo: string;
};

const CancelButton = ({ variant = 'contained', linkTo, isDisabled }: Props) => {
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
