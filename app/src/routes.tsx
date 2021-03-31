import React from 'react';
import { Navigate } from 'react-router-dom';

import MainLayout from 'src/layouts/MainLayout';
import HomePage from 'src/pages/HomePage';
import TeamsPage from 'src/pages/TeamsPage';
import AboutPage from 'src/pages/AboutPage';
import NotFoundPage from 'src/pages/NotFoundPage';

const routes = [
  {
    path: '/',
    element: <MainLayout />,
    children: [
      { path: 'teams', element: <TeamsPage /> },
      { path: 'about', element: <AboutPage /> },
      { path: '/', element: <HomePage /> },
      { path: '404', element: <NotFoundPage /> },
      { path: '*', element: <Navigate to="/404" /> },
    ],
  },
];

export default routes;
