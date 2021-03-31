import React from 'react';
import { render, screen } from '@testing-library/react';
import HomePage from './index';

test('renders Home heading', () => {
  render(<HomePage />);
  const h1Element = screen.getByText(/Home/i);
  expect(h1Element).toBeInTheDocument();
});
