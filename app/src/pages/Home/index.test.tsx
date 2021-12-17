import React from 'react';
import { render, screen } from '@testing-library/react';
import Home from './index';

test('renders Home heading', () => {
  render(<Home />);
  const h1Element = screen.getByText(/Home/i);
  expect(h1Element).toBeInTheDocument();
});
