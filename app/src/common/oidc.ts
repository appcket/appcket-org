const oidcConfig = {
  authority: `${import.meta.env.VITE_ACCOUNTS_URL}/realms/appcket`,
  client_id: 'appcket_app',
  redirect_uri: `${import.meta.env.VITE_APP_URL}`,
  onSigninCallback: (): void => {
    window.history.replaceState({}, document.title, window.location.pathname);
  },
};

export default oidcConfig;
