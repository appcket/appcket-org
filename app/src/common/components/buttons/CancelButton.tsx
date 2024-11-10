import Button, { ButtonPropsVariantOverrides } from '@mui/material/Button';
import { OverridableStringUnion } from '@mui/types';
import PropTypes from 'prop-types';
import { Undo } from '@mui/icons-material';

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
      color="secondary"
      component={Link}
      to={linkTo}
      disabled={isDisabled}
      startIcon={<Undo />}
    >
      Cancel
    </Button>
  );
};

CancelButton.propTypes = {
  variant: PropTypes.string,
  linkTo: PropTypes.string,
  isDIsabled: PropTypes.bool,
};

export default CancelButton;
