import assert from "assert";
import { getLoginUrl } from "../src/lib/getLoginUrl.js";

// Happy path: env provided
assert.strictEqual(
  getLoginUrl({ PUBLIC_APP_URL: "https://example.com" }),
  "https://example.com"
);
// Fallback to process.env (simulate)
process.env.PUBLIC_APP_URL = "https://proc-env.test";
assert.strictEqual(getLoginUrl(), "https://proc-env.test");
// No env -> fallback /
delete process.env.PUBLIC_APP_URL;
assert.strictEqual(getLoginUrl(), "/");

console.log("getLoginUrl tests passed");
