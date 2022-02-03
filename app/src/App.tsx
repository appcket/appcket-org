import * as React from 'react';
import { Navigate, Route, Routes } from 'react-router-dom';
import { SnackbarProvider } from 'notistack';
import CssBaseline from '@mui/material/CssBaseline';
import { ThemeProvider } from '@mui/material/styles';

import theme from 'src/common/theme';
import MainLayout from 'src/common/components/layouts/MainLayout';
import Home from 'src/pages/Home';
import Teams from 'src/pages/Teams';
import Projects from 'src/pages/Projects';
import About from 'src/pages/About';
import NotFound from 'src/pages/NotFound';
import Unauthorized from 'src/pages/Unauthorized';

export default function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <SnackbarProvider
        maxSnack={3}
        autoHideDuration={7000}
        anchorOrigin={{
          vertical: 'top',
          horizontal: 'right',
        }}
        iconVariant={{
          success: '✅ ',
          error: '✖️ ',
          warning: '⚠️ ',
          info: 'ℹ️ ',
        }}
      >
        <Routes>
          <Route path="/" element={<MainLayout />}>
            <Route index element={<Home />} />
            <Route path="teams/*" element={<Teams />} />
            <Route path="projects/*" element={<Projects />} />
            <Route path="about" element={<About />} />
            <Route path="unauthorized" element={<Unauthorized />} />
            <Route path="404" element={<NotFound />} />
            <Route path="*" element={<Navigate to="/404" />} />
          </Route>
        </Routes>
      </SnackbarProvider>
    </ThemeProvider>
  );
}
