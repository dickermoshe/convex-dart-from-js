import { AuthConfig } from "convex/server";

export default {
  providers: [
    {
      type: "customJwt",
      applicationID: "convex-dart-integration",
      issuer: "https://convex-dart-integration.test",
      jwks: "data:text/plain;charset=utf-8;base64,eyJrZXlzIjpbeyJrdHkiOiJSU0EiLCJuIjoic2N0c0llYVhIUXlRNnRrWDdTQjZFZTVSWGhBOVB1YUlnWXkzcG82WXFqdTk0aVpNbHdFLS1zbXpTNW5DVWMyZ1RYSFludTZ2Zm5hVFZWSW5aUlQtZGpUVWtEWkJZZlA1d2RuUlhjTUxYU1ozRzFPbFY2ZlN6c1dQaDJXMU9mVlZmbWRmYXVPNWFsd25UMGc0R0ZiY2hHR1Rvc0xmMmM3UUlJQ2ZUUzBvNUR0dGMxeWd6dURuLXhRQzd6dm10QkEtMjhzblpCUDRXWFlmQ2xOZkFFSEpYNklLSTZ6aElFWFJ0U3NvMkpqeXZuOHQtVkdnek1Ca3pfbnZ4bVl4N1dGaFlCbzJ0R2k2V25uVWlER1BsaV9OSk84SWpodHU3bGhwR21QYmFZcE4xX3BzUXZ4NFlMMlFZb2pPd2lMVkhHNVkyOUprOWxfd1JHU3JHVlN5Z0ktcld3IiwiZSI6IkFRQUIiLCJ1c2UiOiJzaWciLCJhbGciOiJSUzI1NiIsImtpZCI6ImNvbnZleC1kYXJ0LWludGVncmF0aW9uLXRlc3QifV19",
      algorithm: "RS256",
    },
  ],
} satisfies AuthConfig;
