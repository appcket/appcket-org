import Button, { ButtonPropsVariantOverrides } from '@mui/material/Button';
import { OverridableStringUnion } from '@mui/types';
import PropTypes from 'prop-types';
import { HiOutlinePencil } from 'react-icons/hi';

import { Link } from 'react-router-dom';

type Props = {
  entityType?: string;
  variant?: OverridableStringUnion<'text' | 'outlined' | 'contained', ButtonPropsVariantOverrides>;
  isDisabled?: boolean;
  linkTo: string;
};

const EditButton = ({ entityType, variant = 'contained', linkTo, isDisabled }: Props) => {
  return (
    <Button
      variant={variant}
      color="secondary"
      component={Link}
      to={linkTo}
      disabled={isDisabled}
      startIcon={<HiOutlinePencil />}
    >
      Edit {entityType}
    </Button>
  );
};

EditButton.propTypes = {
  entityType: PropTypes.string,
  variant: PropTypes.string,
  linkTo: PropTypes.string,
  isDIsabled: PropTypes.bool,
};

export default EditButton;
