import React from 'react';
import { Navigate } from 'react-router-dom';

import { MainLayout } from 'src/components/layouts/MainLayout';
import { Home } from 'src/pages/Home';
import { Teams } from 'src/pages/Teams';
import { Team } from 'src/pages/Teams/Team';
import { About } from 'src/pages/About';
import { NotFound } from 'src/pages/NotFound';

const routes = [
  {
    path: '/',
    element: <MainLayout />,
    children: [
      { path: 'teams', element: <Teams /> },
      { path: 'teams/:teamId', element: <Team /> },
      { path: 'about', element: <About /> },
      { path: '/', element: <Home /> },
      { path: '404', element: <NotFound /> },
      { path: '*', element: <Navigate to="/404" /> },
    ],
  },
];

export default routes;
