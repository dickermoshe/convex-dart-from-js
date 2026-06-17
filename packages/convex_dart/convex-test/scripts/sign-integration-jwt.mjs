import { createSign } from "node:crypto";
import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const privateKeyPath = join(
  __dirname,
  "..",
  "keys",
  "integration-test-private.pem",
);

const issuer = "https://convex-dart-integration.test";
const audience = "convex-dart-integration";
const kid = "convex-dart-integration-test";

const privateKey = readFileSync(privateKeyPath, "utf8");
const now = Math.floor(Date.now() / 1000);

const header = {
  alg: "RS256",
  typ: "JWT",
  kid,
};
const payload = {
  iss: issuer,
  aud: audience,
  sub: "convex-dart-integration-user",
  name: "Convex Dart Integration",
  iat: now,
  exp: now + 60 * 60,
};

const signingInput = `${base64UrlJson(header)}.${base64UrlJson(payload)}`;
const signature = createSign("RSA-SHA256")
  .update(signingInput)
  .sign(privateKey);

process.stdout.write(`${signingInput}.${base64Url(signature)}`);

function base64UrlJson(value) {
  return base64Url(Buffer.from(JSON.stringify(value)));
}

function base64Url(buffer) {
  return buffer
    .toString("base64")
    .replaceAll("+", "-")
    .replaceAll("/", "_")
    .replaceAll("=", "");
}
