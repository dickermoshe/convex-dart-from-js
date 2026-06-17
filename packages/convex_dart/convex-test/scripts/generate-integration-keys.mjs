import { generateKeyPairSync } from "node:crypto";
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const root = join(__dirname, "..");
const keysDir = join(root, "keys");
const privateKeyPath = join(keysDir, "integration-test-private.pem");
const authConfigPath = join(root, "convex", "auth.config.ts");

const issuer = "https://convex-dart-integration.test";
const applicationID = "convex-dart-integration";
const kid = "convex-dart-integration-test";

mkdirSync(keysDir, { recursive: true });

const { privateKey, publicKey } = generateKeyPairSync("rsa", {
  modulusLength: 2048,
  publicKeyEncoding: { type: "spki", format: "jwk" },
  privateKeyEncoding: { type: "pkcs8", format: "pem" },
});

writeFileSync(privateKeyPath, privateKey);

const jwks = {
  keys: [
    {
      kty: publicKey.kty,
      n: publicKey.n,
      e: publicKey.e,
      use: "sig",
      alg: "RS256",
      kid,
    },
  ],
};
const encodedJwks = Buffer.from(JSON.stringify(jwks)).toString("base64");

writeFileSync(
  authConfigPath,
  `import { AuthConfig } from "convex/server";

export default {
  providers: [
    {
      type: "customJwt",
      applicationID: "${applicationID}",
      issuer: "${issuer}",
      jwks: "data:text/plain;charset=utf-8;base64,${encodedJwks}",
      algorithm: "RS256",
    },
  ],
} satisfies AuthConfig;
`,
);

console.log(`Wrote ${privateKeyPath} and ${authConfigPath}`);
