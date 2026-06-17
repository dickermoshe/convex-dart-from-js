import { AuthConfig } from "convex/server";

export default {
  providers: [
    {
      type: "customJwt",
      applicationID: "convex-dart-integration",
      issuer: "https://convex-dart-integration.test",
      jwks: "data:text/plain;charset=utf-8;base64,eyJrZXlzIjpbeyJrdHkiOiJSU0EiLCJuIjoieHVzRmdwUkxTQzcwTDEzV1RHVlgyRHBjMU5JeWpoOXRXd1otOU9BektqdUtjN0dYSVZVXzR6ZWM2RVlMbXYxRVlTUkl4ZEJTeTNwWFc5S1F2VFBvVDFIUjZpdnF5bnFMeFd0N3I0MnEtWkdPN3B0UzJqdk5LUENRUDM4eWtVUk9pR2FyS2pnQ053T0RoUDBzVndxejdEM0hqU1F1U2dQQXBhRm11VTdCdjVZX3VDbERHNVlwWkIzc0JEM2VNaGNiZDJsT2JEcHN2NDhBMUlrQVJjVzdxWTIyQllISVV4dTUyVHlvSGJRYzZlSkVEYW1PbWlFb0I4c0kyLWRjSzJQN1B5ZkNJemh6aGtqYlM4SFZ3dWxoQXJYSS16bTcwSGlTNUdOaTlsVngxUUh2UzcwLXh5eHNsRmVoZnJFUkk4Qk94a29hRnEteFpCZUJvaWlDalEzazF3IiwiZSI6IkFRQUIiLCJ1c2UiOiJzaWciLCJhbGciOiJSUzI1NiIsImtpZCI6ImNvbnZleC1kYXJ0LWludGVncmF0aW9uLXRlc3QifV19",
      algorithm: "RS256",
    },
  ],
} satisfies AuthConfig;
