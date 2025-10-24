import '@testing-library/jest-dom';
import { render, screen } from '@testing-library/react';
import { HelmetProvider } from '@dr.pogodin/react-helmet';

import Home from 'src/pages/Home/index';

test('simple render', () => {
  render(
    <HelmetProvider>
      <Home />
    </HelmetProvider>,
  );

  expect(screen.getByText('Home')).toBeInTheDocument();
  expect(screen.getByText('Welcome to the Appcket home page')).toBeInTheDocument();
});
