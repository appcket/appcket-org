import { forwardRef, ReactNode } from 'react';
import { Helmet } from 'react-helmet-async';

type Props = {
  children: ReactNode | ReactNode[];
  title: string;
};

const Page = forwardRef<HTMLDivElement, Props>(({ children, title = '', ...rest }: Props, ref) => (
  <div ref={ref} {...rest} style={{ height: '100%' }}>
    <Helmet>
      <title>Appcket - {title}</title>
    </Helmet>
    {children}
  </div>
));

Page.displayName = 'Page';

export default Page;
