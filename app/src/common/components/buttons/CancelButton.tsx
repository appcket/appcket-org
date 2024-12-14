import Button, { ButtonPropsVariantOverrides } from '@mui/material/Button';
import { OverridableStringUnion } from '@mui/types';
import PropTypes from 'prop-types';
import { TiCancel } from 'react-icons/ti';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';

type Props = {
  variant?: OverridableStringUnion<'text' | 'outlined' | 'contained', ButtonPropsVariantOverrides>;
  isDisabled?: boolean;
  linkTo: string;
};

const CancelButton = ({ variant = 'contained', linkTo, isDisabled }: Props) => {
  const { t } = useTranslation();

  return (
    <Button
      variant={variant}
      color="secondary"
      component={Link}
      to={linkTo}
      disabled={isDisabled}
      startIcon={<TiCancel />}
    >
      {t('common.cancel')}
    </Button>
  );
};

CancelButton.propTypes = {
  variant: PropTypes.string,
  linkTo: PropTypes.string,
  isDIsabled: PropTypes.bool,
};

export default CancelButton;
