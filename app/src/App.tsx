import { Navigate, Route, Routes } from 'react-router-dom';
import { SnackbarProvider } from 'notistack';
import { CssBaseline } from '@mui/material';
import { useAuth } from 'react-oidc-context';
import { ThemeProvider } from '@mui/material/styles';

import theme from 'src/common/theme';
import Loading from 'src/common/components/Loading';
import MainLayout from 'src/common/components/layouts/MainLayout';
import Home from 'src/pages/Home';
import About from 'src/pages/About';
import Projects from 'src/pages/Projects';
import Tasks from 'src/pages/Tasks';
import Teams from 'src/pages/Teams';
import NotFound from 'src/pages/NotFound';
import Unauthorized from 'src/pages/Unauthorized';

export default function App() {
  const auth = useAuth();

  if (auth.isLoading) {
    return <Loading />;
  } else {
    if (!auth.isAuthenticated) {
      auth.signinRedirect();
    }
  }

  if (auth.error) {
    return <div>Authentication error... {auth.error.message}</div>;
  }

  if (auth.isAuthenticated) {
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
              <Route path="about" element={<About />} />
              <Route path="teams/*" element={<Teams />} />
              <Route path="projects/*" element={<Projects />} />
              <Route path="tasks/*" element={<Tasks />} />
              <Route path="unauthorized" element={<Unauthorized />} />
              <Route path="404" element={<NotFound />} />
              <Route path="*" element={<Navigate to="/404" />} />
            </Route>
          </Routes>
        </SnackbarProvider>
      </ThemeProvider>
    );
  }

  return <button onClick={() => void auth.signinRedirect()}>Log in</button>;
}
