import React from 'react';
import { Navigate, Route, Routes } from 'react-router-dom';
import { ThemeProvider, Theme, StyledEngineProvider } from '@mui/material';
import { SnackbarProvider } from 'notistack';

import GlobalStyles from 'src/common/components/GlobalStyles';
import theme from 'src/common/theme';
import MainLayout from 'src/common/components/layouts/MainLayout';
import Home from 'src/pages/Home';
import Teams from 'src/pages/Teams';
import About from 'src/pages/About';
import NotFound from 'src/pages/NotFound';
import Unauthorized from 'src/pages/Unauthorized';

declare module '@mui/styles/defaultTheme' {
  interface DefaultTheme extends Theme {}
}

const App = () => {
  return (
    <StyledEngineProvider injectFirst>
      <ThemeProvider theme={theme}>
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
          <GlobalStyles />
          <Routes>
            <Route path="/" element={<MainLayout />}>
              <Route index element={<Home />} />
              <Route path="teams/*" element={<Teams />} />
              <Route path="about" element={<About />} />
              <Route path="unauthorized" element={<Unauthorized />} />
              <Route path="404" element={<NotFound />} />
              <Route path="*" element={<Navigate to="/404" />} />
            </Route>
          </Routes>
        </SnackbarProvider>
      </ThemeProvider>
    </StyledEngineProvider>
  );
};

export default App;
