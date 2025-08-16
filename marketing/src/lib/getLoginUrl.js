// Returns the login URL from env, with a safe fallback.
// Accepts an optional env object for testing.
export function getLoginUrl(env) {
  if (env && env.PUBLIC_APP_URL) return env.PUBLIC_APP_URL;
  if (
    typeof process !== "undefined" &&
    process.env &&
    process.env.PUBLIC_APP_URL
  )
    return process.env.PUBLIC_APP_URL;
  return "/";
}

// CommonJS fallback
try {
  // @ts-ignore
  if (typeof module !== "undefined" && module.exports)
    module.exports.getLoginUrl = getLoginUrl;
} catch (e) {
  // ignore
}
