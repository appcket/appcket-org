import Button from '@mui/material/Button';
import PropTypes from 'prop-types';
import { HiOutlinePencil } from 'react-icons/hi';

import { Link } from 'react-router-dom';

type Props = {
  entityType?: string;
  variant?: string;
  isDisabled?: boolean;
  linkTo: string;
};

const EditButton = ({ entityType, variant, linkTo, isDisabled }: Props) => {
  return (
    <Button
      variant={variant}
      component={Link}
      to={linkTo}
      disabled={isDisabled}
      startIcon={<HiOutlinePencil />}
    >
      Edit {entityType}
    </Button>
  );
};

EditButton.defaultProps = {
  entityType: '',
  variant: 'contained',
  linkTo: '',
  isDisabled: false,
};

EditButton.propTypes = {
  entityType: PropTypes.string,
  variant: PropTypes.string,
  linkTo: PropTypes.string,
  isDIsabled: PropTypes.bool,
};

export default EditButton;
