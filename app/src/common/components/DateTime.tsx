import PropTypes from 'prop-types';
import { formatDatetime } from 'src/common/utils/general';

type Props = {
  dateTimeString: string;
};

const DateTime = ({ dateTimeString }: Props) => {
  return formatDatetime(dateTimeString);
};

DateTime.defaultProps = {
  dateTimeString: new Date().toString(),
};

DateTime.propTypes = {
  dateTimeString: PropTypes.string,
};

export default DateTime;
