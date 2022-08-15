import { forwardRef, ReactNode } from 'react';
import { Helmet } from 'react-helmet-async';
import PropTypes from 'prop-types';

type Props = {
  children: ReactNode;
  title: string;
};

const Page = forwardRef<HTMLDivElement, Props>(({ children, title = '', ...rest }: Props, ref) => (
  <div ref={ref} {...rest}>
    <Helmet>
      <title>Appcket - {title}</title>
    </Helmet>
    {children}
  </div>
));

Page.displayName = 'Page';

Page.propTypes = {
  children: PropTypes.element,
};

export default Page;
