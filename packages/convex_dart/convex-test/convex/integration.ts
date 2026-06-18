import { ConvexError, v } from "convex/values";
import { action, mutation, query } from "./_generated/server";

export const echo = query({
  args: { message: v.optional(v.string()) },
  returns: v.any(),
  handler: async (_ctx, args) => args,
});

export const types = query({
  args: {},
  returns: v.any(),
  handler: async () => ({
    int64: 42n,
    bytes: new Uint8Array([1, 2, 3]).buffer,
    nested: { a: "x" },
  }),
});

export const getCounter = query({
  args: { name: v.string() },
  returns: v.union(v.int64(), v.null()),
  handler: async (ctx, args) => {
    const row = await ctx.db
      .query("counters")
      .withIndex("by_name", (q) => q.eq("name", args.name))
      .unique();
    return row?.value ?? null;
  },
});

export const increment = mutation({
  args: { name: v.string() },
  returns: v.int64(),
  handler: async (ctx, args) => {
    const row = await ctx.db
      .query("counters")
      .withIndex("by_name", (q) => q.eq("name", args.name))
      .unique();
    if (row) {
      const next = row.value + 1n;
      await ctx.db.patch(row._id, { value: next });
      return next;
    }
    await ctx.db.insert("counters", { name: args.name, value: 1n });
    return 1n;
  },
});

export const compute = action({
  args: { x: v.number() },
  returns: v.number(),
  handler: async (_ctx, args) => args.x * 2,
});

export const throws = query({
  args: {},
  returns: v.null(),
  handler: async () => {
    throw new ConvexError({ code: "test" });
  },
});

export const throwsString = query({
  args: {},
  returns: v.null(),
  handler: async () => {
    throw new ConvexError("string error");
  },
});

export const throwsMutation = mutation({
  args: {},
  returns: v.null(),
  handler: async () => {
    throw new ConvexError({ code: "mutation" });
  },
});

export const throwsAction = action({
  args: {},
  returns: v.null(),
  handler: async () => {
    throw new ConvexError({ code: "action" });
  },
});

export const authRequired = query({
  args: {},
  returns: v.string(),
  handler: async (ctx) => {
    const identity = await ctx.auth.getUserIdentity();
    if (!identity) {
      throw new Error("Not authenticated");
    }
    return identity.tokenIdentifier;
  },
});
