const oidcConfig = {
  authority: `${process.env.REACT_APP_ACCOUNTS_URL}/realms/appcket`,
  client_id: 'appcket_app',
  redirect_uri: `${process.env.REACT_APP_APP_URL}`,
  onSigninCallback: (): void => {
    window.history.replaceState(
      {},
      document.title,
      window.location.pathname
    )
  }
};

export default oidcConfig;
