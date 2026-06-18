import { httpRouter } from "convex/server";
import { httpAction } from "./_generated/server";

const http = httpRouter();

http.route({
  method: "GET",
  pathPrefix: "/api/v1/",
  handler: httpAction(async (ctx, request) => {
    return new Response(`1`);
  }),
});
http.route({
  method: "GET",
  path: "/api/v1/",
  handler: httpAction(async (ctx, request) => {
    return new Response(`2`);
  }),
});
http.route({
  method: "POST",
  path: "/api/v1/",
  handler: httpAction(async (ctx, request) => {
    return new Response(`3`);
  }),
});
http.route({
  method: "PUT",
  path: "/api/v1/",
  handler: httpAction(async (ctx, request) => {
    return new Response(`4`);
  }),
});
http.route({
  method: "DELETE",
  path: "/api/v1/",
  handler: httpAction(async (ctx, request) => {
    return new Response(`5`);
  }),
});
http.route({
  method: "PATCH",
  path: "/api/v1/",
  handler: httpAction(async (ctx, request) => {
    return new Response(`6`);
  }),
});
http.route({
  method: "OPTIONS",
  path: "/api/v1/",
  handler: httpAction(async (ctx, request) => {
    return new Response(`7`);
  }),
});
export default http;