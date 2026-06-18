import { Id } from "./_generated/dataModel";
import { query, mutation } from "./_generated/server";
import { v } from "convex/values";
export const voidReturn = query({
  handler: (ctx, args) => {
    return;
  },
});

export const strReturn = query({
  returns: v.string(),
  handler: (ctx, args) => {
    return "Hi";
  },
});

export const numReturn = query({
  returns: v.number(),
  handler: (ctx, args) => {
    return 1;
  },
});

export const boolReturn = query({
  returns: v.boolean(),
  handler: (ctx, args) => {
    return true;
  },
});

export const int64Return = query({
  returns: v.int64(),
  handler: (ctx, args) => {
    return 1n;
  },
});

export const bytesReturn = query({
  returns: v.bytes(),
  handler: (ctx, args) => {
    const uint8View = new Uint8Array([1, 2, 3, 4, 5, 6, 7, 8]);
    return uint8View.buffer;
  },
});

export const nullReturn = query({
  returns: v.null(),
  handler: (ctx, args) => {
    return null;
  },
});

export const unionReturn = query({
  returns: v.union(v.string(), v.number()),
  handler: (ctx, args) => {
    return "Hi";
  },
});

export const arrayReturn = query({
  returns: v.array(v.string()),
  handler: (ctx, args) => {
    return ["Hi", "Hello"];
  },
});
// Literals cannot be returned
// export const literalReturn = query({
//   returns: v.object({
//     i: v.union(v.literal("Hi"), v.literal("Hello")),
//   }),
//   handler: (ctx, args) => {
//     return { i: "Hello" };
//   },
// });

export const idReturn = query({
  returns: v.id("tasks"),
  handler: async (ctx, args) => {
    const task = await ctx.db.query("tasks").first();
    return task!._id;
  },
});

export const recordReturn = query({
  returns: v.record(v.string(), v.string()),
  handler: (ctx, args) => {
    return { i: "Hello" };
  },
});

export const anyReturn = query({
  returns: v.any(),
  handler: (ctx, args) => {
    return "Hello";
  },
});
export const objectReturn = query({
  returns: v.object({
    i: v.string(),
  }),
  handler: (ctx, args) => {
    return { i: "Hello" };
  },
});

export const privateObjectReturn = query({
  returns: v.object({
    _i: v.string(),
  }),
  handler: (ctx, args) => {
    return { _i: "Hello" };
  },
});

export const emptyObjectArgsReturn = query({
  args: {},
  returns: {},
  handler: (ctx, args) => {
    return {};
  },
});