import { Id } from "./_generated/dataModel";
import { query, mutation } from "./_generated/server";
import { v } from "convex/values";

// Primitive types
export const query1 = query({
  args: {
    i: v.string(),
  },
  returns: {
    i: v.string(),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query2 = query({
  args: {
    i: v.number(),
  },
  returns: {
    i: v.number(),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query3 = query({
  args: {
    i: v.boolean(),
  },
  returns: {
    i: v.boolean(),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query4 = query({
  args: {
    i: v.int64(),
  },
  returns: {
    i: v.int64(),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query5 = query({
  args: {
    i: v.bytes(),
  },
  returns: {
    i: v.bytes(),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query6 = query({
  args: {
    i: v.id("tasks"),
  },
  returns: {
    i: v.id("tasks"),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query7 = query({
  args: {
    i: v.any(),
  },
  returns: {
    i: v.any(),
  },
  handler: (ctx, args) => {
    return args;
  },
});
// Invalid
// export const query8 = query({
//   args: {
//     i: v.null(),
//   },
//   returns: {
//     i: v.null(),
//   },
//   handler: (ctx, args) => {
//     return args;
//   },
// });

export const query9 = query({
  args: {
    i: v.literal("hi"),
  },
  returns: {
    i: v.literal("hi"),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query10 = query({
  args: {
    i: v.literal(1.0),
  },
  returns: {
    i: v.literal(1.0),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query11 = query({
  args: {
    i: v.literal(true),
  },
  returns: {
    i: v.literal(true),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Optional Primitive types
export const query13 = query({
  args: {
    i: v.optional(v.string()),
  },
  returns: {
    i: v.optional(v.string()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query14 = query({
  args: {
    i: v.optional(v.number()),
  },
  returns: {
    i: v.optional(v.number()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query15 = query({
  args: {
    i: v.optional(v.boolean()),
  },
  returns: {
    i: v.optional(v.boolean()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query16 = query({
  args: {
    i: v.optional(v.int64()),
  },
  returns: {
    i: v.optional(v.int64()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query17 = query({
  args: {
    i: v.optional(v.bytes()),
  },
  returns: {
    i: v.optional(v.bytes()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query18 = query({
  args: {
    i: v.optional(v.id("tasks")),
  },
  returns: {
    i: v.optional(v.id("tasks")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query19 = query({
  args: {
    i: v.optional(v.any()),
  },
  returns: {
    i: v.optional(v.any()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query20 = query({
  args: {
    i: v.optional(v.literal("hi")),
  },
  returns: {
    i: v.optional(v.literal("hi")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query21 = query({
  args: {
    i: v.optional(v.literal(1)),
  },
  returns: {
    i: v.optional(v.literal(1)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query22 = query({
  args: {
    i: v.optional(v.literal(true)),
  },
  returns: {
    i: v.optional(v.literal(true)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// export const query23 = query({
//   args: {
//     i: v.optional(v.literal(BigInt(1))),
//   },
//   returns: {
//     i: v.optional(v.literal(BigInt(1))),
//   },
//   handler: (ctx, args) => {
//     return args;
//   },
// });

// Nullable Primitive types
export const query24 = query({
  args: {
    i: v.union(v.string(), v.null()),
  },
  returns: {
    i: v.union(v.string(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query25 = query({
  args: {
    i: v.union(v.number(), v.null()),
  },
  returns: {
    i: v.union(v.number(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query26 = query({
  args: {
    i: v.union(v.boolean(), v.null()),
  },
  returns: {
    i: v.union(v.boolean(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query27 = query({
  args: {
    i: v.union(v.int64(), v.null()),
  },
  returns: {
    i: v.union(v.int64(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query28 = query({
  args: {
    i: v.union(v.bytes(), v.null()),
  },
  returns: {
    i: v.union(v.bytes(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query29 = query({
  args: {
    i: v.union(v.id("tasks"), v.null()),
  },
  returns: {
    i: v.union(v.id("tasks"), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query30 = query({
  args: {
    i: v.union(v.any(), v.null()),
  },
  returns: {
    i: v.union(v.any(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query31 = query({
  args: {
    i: v.union(v.literal("hi"), v.null()),
  },
  returns: {
    i: v.union(v.literal("hi"), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query32 = query({
  args: {
    i: v.union(v.literal(1), v.null()),
  },
  returns: {
    i: v.union(v.literal(1), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query33 = query({
  args: {
    i: v.union(v.literal(true), v.null()),
  },
  returns: {
    i: v.union(v.literal(true), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});
export const query34WithNull = query({
  args: {
    i: v.union(v.literal("blue"), v.literal("red"), v.null()),
  },
  returns: {
    i: v.union(v.literal("blue"), v.literal("red"), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});
export const query34NonNull = query({
  args: {
    i: v.union(v.literal("blue"), v.literal("red")),
  },
  returns: {
    i: v.union(v.literal("blue"), v.literal("red")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// export const query34 = query({
//   args: {
//     i: v.union(v.literal(BigInt(1)), v.null()),
//   },
//   returns: {
//     i: v.union(v.literal(BigInt(1)), v.null()),
//   },
//   handler: (ctx, args) => {
//     return args;
//   },
// });

// Array Primitive types
export const query35 = query({
  args: {
    i: v.array(v.string()),
  },
  returns: {
    i: v.array(v.string()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query36 = query({
  args: {
    i: v.array(v.number()),
  },
  returns: {
    i: v.array(v.number()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query37 = query({
  args: {
    i: v.array(v.boolean()),
  },
  returns: {
    i: v.array(v.boolean()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query38 = query({
  args: {
    i: v.array(v.int64()),
  },
  returns: {
    i: v.array(v.int64()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query39 = query({
  args: {
    i: v.array(v.bytes()),
  },
  returns: {
    i: v.array(v.bytes()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query40 = query({
  args: {
    i: v.array(v.id("tasks")),
  },
  returns: {
    i: v.array(v.id("tasks")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query41 = query({
  args: {
    i: v.array(v.any()),
  },
  returns: {
    i: v.array(v.any()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query42 = query({
  args: {
    i: v.array(v.null()),
  },
  returns: {
    i: v.array(v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query43 = query({
  args: {
    i: v.array(v.literal("hi")),
  },
  returns: {
    i: v.array(v.literal("hi")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query44 = query({
  args: {
    i: v.array(v.literal(1)),
  },
  returns: {
    i: v.array(v.literal(1)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query45 = query({
  args: {
    i: v.array(v.literal(true)),
  },
  returns: {
    i: v.array(v.literal(true)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// export const query46 = query({
//   args: {
//     i: v.array(v.literal(BigInt(1))),
//   },
//   returns: {
//     i: v.array(v.literal(BigInt(1))),
//   },
//   handler: (ctx, args) => {
//     return args;
//   },
// });

// Array Nullable Primitive types
export const query58 = query({
  args: {
    i: v.array(v.union(v.string(), v.null())),
  },
  returns: {
    i: v.array(v.union(v.string(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query59 = query({
  args: {
    i: v.array(v.union(v.number(), v.null())),
  },
  returns: {
    i: v.array(v.union(v.number(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query60 = query({
  args: {
    i: v.array(v.union(v.boolean(), v.null())),
  },
  returns: {
    i: v.array(v.union(v.boolean(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query61 = query({
  args: {
    i: v.array(v.union(v.int64(), v.null())),
  },
  returns: {
    i: v.array(v.union(v.int64(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query62 = query({
  args: {
    i: v.array(v.union(v.bytes(), v.null())),
  },
  returns: {
    i: v.array(v.union(v.bytes(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query63 = query({
  args: {
    i: v.array(v.union(v.id("tasks"), v.null())),
  },
  returns: {
    i: v.array(v.union(v.id("tasks"), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query64 = query({
  args: {
    i: v.array(v.union(v.any(), v.null())),
  },
  returns: {
    i: v.array(v.union(v.any(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query65 = query({
  args: {
    i: v.array(v.union(v.literal("hi"), v.null())),
  },
  returns: {
    i: v.array(v.union(v.literal("hi"), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query66 = query({
  args: {
    i: v.array(v.union(v.literal(1), v.null())),
  },
  returns: {
    i: v.array(v.union(v.literal(1), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query67 = query({
  args: {
    i: v.array(v.union(v.literal(true), v.null())),
  },
  returns: {
    i: v.array(v.union(v.literal(true), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// export const query68 = query({
//   args: {
//     i: v.array(v.union(v.literal(BigInt(1)), v.null())),
//   },
//   returns: {
//     i: v.array(v.union(v.literal(BigInt(1)), v.null())),
//   },
//   handler: (ctx, args) => {
//     return args;
//   },
// });

// Record Primitive types
export const query69 = query({
  args: {
    i: v.record(v.string(), v.string()),
  },
  returns: {
    i: v.record(v.string(), v.string()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query70 = query({
  args: {
    i: v.record(v.string(), v.number()),
  },
  returns: {
    i: v.record(v.string(), v.number()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query71 = query({
  args: {
    i: v.record(v.string(), v.boolean()),
  },
  returns: {
    i: v.record(v.string(), v.boolean()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query72 = query({
  args: {
    i: v.record(v.string(), v.int64()),
  },
  returns: {
    i: v.record(v.string(), v.int64()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query73 = query({
  args: {
    i: v.record(v.string(), v.bytes()),
  },
  returns: {
    i: v.record(v.string(), v.bytes()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query74 = query({
  args: {
    i: v.record(v.string(), v.id("tasks")),
  },
  returns: {
    i: v.record(v.string(), v.id("tasks")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query75 = query({
  args: {
    i: v.record(v.string(), v.any()),
  },
  returns: {
    i: v.record(v.string(), v.any()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query76 = query({
  args: {
    i: v.record(v.string(), v.null()),
  },
  returns: {
    i: v.record(v.string(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query77 = query({
  args: {
    i: v.record(v.string(), v.literal("hi")),
  },
  returns: {
    i: v.record(v.string(), v.literal("hi")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query78 = query({
  args: {
    i: v.record(v.string(), v.literal(1)),
  },
  returns: {
    i: v.record(v.string(), v.literal(1)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query79 = query({
  args: {
    i: v.record(v.string(), v.literal(true)),
  },
  returns: {
    i: v.record(v.string(), v.literal(true)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// export const query80 = query({
//   args: {
//     i: v.record(v.string(), v.literal(BigInt(1))),
//   },
//   returns: {
//     i: v.record(v.string(), v.literal(BigInt(1))),
//   },
//   handler: (ctx, args) => {
//     return args;
//   },
// });

// Record Nullable Primitive types
export const query81 = query({
  args: {
    i: v.record(v.string(), v.union(v.string(), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.string(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query82 = query({
  args: {
    i: v.record(v.string(), v.union(v.number(), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.number(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query83 = query({
  args: {
    i: v.record(v.string(), v.union(v.boolean(), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.boolean(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query84 = query({
  args: {
    i: v.record(v.string(), v.union(v.int64(), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.int64(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query85 = query({
  args: {
    i: v.record(v.string(), v.union(v.bytes(), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.bytes(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query86 = query({
  args: {
    i: v.record(v.string(), v.union(v.id("tasks"), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.id("tasks"), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query87 = query({
  args: {
    i: v.record(v.string(), v.union(v.any(), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.any(), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query88 = query({
  args: {
    i: v.record(v.string(), v.union(v.literal("hi"), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.literal("hi"), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query89 = query({
  args: {
    i: v.record(v.string(), v.union(v.literal(1), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.literal(1), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query90 = query({
  args: {
    i: v.record(v.string(), v.union(v.literal(true), v.null())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.literal(true), v.null())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// export const query91 = query({
//   args: {
//     i: v.record(v.string(), v.union(v.literal(BigInt(1)), v.null())),
//   },
//   returns: {
//     i: v.record(v.string(), v.union(v.literal(BigInt(1)), v.null())),
//   },
//   handler: (ctx, args) => {
//     return args;
//   },
// });

// Union types - assorted combinations
export const query92 = query({
  args: {
    i: v.union(v.string(), v.number()),
  },
  returns: {
    i: v.union(v.string(), v.number()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query93 = query({
  args: {
    i: v.union(v.boolean(), v.number()),
  },
  returns: {
    i: v.union(v.boolean(), v.number()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query94 = query({
  args: {
    i: v.union(v.string(), v.boolean()),
  },
  returns: {
    i: v.union(v.string(), v.boolean()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// 3-type unions
export const query95 = query({
  args: {
    i: v.union(v.string(), v.number(), v.boolean()),
  },
  returns: {
    i: v.union(v.string(), v.number(), v.boolean()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query96 = query({
  args: {
    i: v.union(v.string(), v.null()),
  },
  returns: {
    i: v.union(v.string(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query97 = query({
  args: {
    i: v.union(v.number(), v.boolean(), v.null()),
  },
  returns: {
    i: v.union(v.number(), v.boolean(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query98 = query({
  args: {
    i: v.union(v.bytes(), v.string()),
  },
  returns: {
    i: v.union(v.bytes(), v.string()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query100 = query({
  args: {
    i: v.union(v.literal("yes"), v.literal("no")),
  },
  returns: {
    i: v.union(v.literal("yes"), v.literal("no")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query101 = query({
  args: {
    i: v.union(v.literal(1), v.literal(2), v.literal(3)),
  },
  returns: {
    i: v.union(v.literal(1), v.literal(2), v.literal(3)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query102 = query({
  args: {
    i: v.union(v.literal("admin"), v.literal("user"), v.literal("guest")),
  },
  returns: {
    i: v.union(v.literal("admin"), v.literal("user"), v.literal("guest")),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query103 = query({
  args: {
    i: v.union(v.int64(), v.number()),
  },
  returns: {
    i: v.union(v.int64(), v.number()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query104 = query({
  args: {
    i: v.union(v.string(), v.number(), v.boolean(), v.null()),
  },
  returns: {
    i: v.union(v.string(), v.number(), v.boolean(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query105 = query({
  args: {
    i: v.union(v.any(), v.null()),
  },
  returns: {
    i: v.union(v.any(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query106 = query({
  args: {
    i: v.union(v.literal(true), v.literal(false)),
  },
  returns: {
    i: v.union(v.literal(true), v.literal(false)),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query107 = query({
  args: {
    i: v.union(v.bytes(), v.int64(), v.null()),
  },
  returns: {
    i: v.union(v.bytes(), v.int64(), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query110 = query({
  args: {
    i: v.union(v.literal("mixed"), v.null()),
  },
  returns: {
    i: v.union(v.literal("mixed"), v.null()),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Object types - various field combinations
export const query111 = query({
  args: {
    i: v.object({
      name: v.string(),
      age: v.number(),
    }),
  },
  returns: {
    i: v.object({
      name: v.string(),
      age: v.number(),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query112 = query({
  args: {
    i: v.object({
      id: v.id("tasks"),
      title: v.string(),
      completed: v.boolean(),
    }),
  },
  returns: {
    i: v.object({
      id: v.id("tasks"),
      title: v.string(),
      completed: v.boolean(),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query113 = query({
  args: {
    i: v.object({
      user: v.object({
        name: v.string(),
        email: v.string(),
      }),
      settings: v.object({
        theme: v.string(),
        notifications: v.boolean(),
      }),
    }),
  },
  returns: {
    i: v.object({
      user: v.object({
        name: v.string(),
        email: v.string(),
      }),
      settings: v.object({
        theme: v.string(),
        notifications: v.boolean(),
      }),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query114 = query({
  args: {
    i: v.object({
      name: v.optional(v.string()),
      email: v.optional(v.string()),
      phone: v.union(v.string(), v.null()),
    }),
  },
  returns: {
    i: v.object({
      name: v.optional(v.string()),
      email: v.optional(v.string()),
      phone: v.union(v.string(), v.null()),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query115 = query({
  args: {
    i: v.object({
      tags: v.array(v.string()),
      categories: v.array(
        v.union(v.literal("work"), v.literal("personal"), v.literal("urgent"))
      ),
    }),
  },
  returns: {
    i: v.object({
      tags: v.array(v.string()),
      categories: v.array(
        v.union(v.literal("work"), v.literal("personal"), v.literal("urgent"))
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query116 = query({
  args: {
    i: v.object({
      metadata: v.record(v.string(), v.any()),
      data: v.object({
        type: v.union(
          v.literal("text"),
          v.literal("number"),
          v.literal("boolean")
        ),
        value: v.any(),
      }),
    }),
  },
  returns: {
    i: v.object({
      metadata: v.record(v.string(), v.any()),
      data: v.object({
        type: v.union(
          v.literal("text"),
          v.literal("number"),
          v.literal("boolean")
        ),
        value: v.any(),
      }),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query117 = query({
  args: {
    i: v.object({
      status: v.union(
        v.literal("pending"),
        v.literal("approved"),
        v.literal("rejected")
      ),
      reviewer: v.optional(
        v.object({
          id: v.id("tasks"),
          name: v.string(),
        })
      ),
      comments: v.array(
        v.object({
          author: v.string(),
          text: v.string(),
          timestamp: v.number(),
        })
      ),
    }),
  },
  returns: {
    i: v.object({
      status: v.union(
        v.literal("pending"),
        v.literal("approved"),
        v.literal("rejected")
      ),
      reviewer: v.optional(
        v.object({
          id: v.id("tasks"),
          name: v.string(),
        })
      ),
      comments: v.array(
        v.object({
          author: v.string(),
          text: v.string(),
          timestamp: v.number(),
        })
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query118 = query({
  args: {
    i: v.object({
      config: v.record(
        v.string(),
        v.union(v.string(), v.number(), v.boolean())
      ),
      fallback: v.object({
        enabled: v.boolean(),
        value: v.any(),
      }),
    }),
  },
  returns: {
    i: v.object({
      config: v.record(
        v.string(),
        v.union(v.string(), v.number(), v.boolean())
      ),
      fallback: v.object({
        enabled: v.boolean(),
        value: v.any(),
      }),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query119 = query({
  args: {
    i: v.object({
      data: v.union(
        v.object({ type: v.literal("text"), content: v.string() }),
        v.object({ type: v.literal("number"), content: v.number() }),
        v.object({ type: v.literal("boolean"), content: v.boolean() })
      ),
    }),
  },
  returns: {
    i: v.object({
      data: v.union(
        v.object({ type: v.literal("text"), content: v.string() }),
        v.object({ type: v.literal("number"), content: v.number() }),
        v.object({ type: v.literal("boolean"), content: v.boolean() })
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query120 = query({
  args: {
    i: v.object({
      items: v.array(
        v.object({
          id: v.string(),
          name: v.string(),
          quantity: v.optional(v.number()),
          price: v.union(v.number(), v.null()),
          metadata: v.record(v.string(), v.any()),
        })
      ),
      total: v.number(),
    }),
  },
  returns: {
    i: v.object({
      items: v.array(
        v.object({
          id: v.string(),
          name: v.string(),
          quantity: v.optional(v.number()),
          price: v.union(v.number(), v.null()),
          metadata: v.record(v.string(), v.any()),
        })
      ),
      total: v.number(),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Advanced nested and complex types
export const query121 = query({
  args: {
    i: v.array(
      v.object({
        user: v.object({
          profile: v.object({
            name: v.string(),
            avatar: v.optional(v.string()),
          }),
          preferences: v.record(
            v.string(),
            v.union(v.string(), v.number(), v.boolean())
          ),
        }),
        posts: v.array(
          v.object({
            id: v.string(),
            content: v.union(
              v.string(),
              v.object({ text: v.string(), media: v.array(v.string()) })
            ),
            tags: v.array(v.string()),
            likes: v.number(),
          })
        ),
      })
    ),
  },
  returns: {
    i: v.array(
      v.object({
        user: v.object({
          profile: v.object({
            name: v.string(),
            avatar: v.optional(v.string()),
          }),
          preferences: v.record(
            v.string(),
            v.union(v.string(), v.number(), v.boolean())
          ),
        }),
        posts: v.array(
          v.object({
            id: v.string(),
            content: v.union(
              v.string(),
              v.object({ text: v.string(), media: v.array(v.string()) })
            ),
            tags: v.array(v.string()),
            likes: v.number(),
          })
        ),
      })
    ),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query122 = query({
  args: {
    i: v.record(
      v.string(),
      v.object({
        type: v.union(
          v.literal("primitive"),
          v.literal("object"),
          v.literal("array")
        ),
        schema: v.union(
          v.object({
            primitive: v.union(
              v.literal("string"),
              v.literal("number"),
              v.literal("boolean")
            ),
          }),
          v.object({ fields: v.record(v.string(), v.string()) }),
          v.object({ elementType: v.string() })
        ),
        required: v.boolean(),
      })
    ),
  },
  returns: {
    i: v.record(
      v.string(),
      v.object({
        type: v.union(
          v.literal("primitive"),
          v.literal("object"),
          v.literal("array")
        ),
        schema: v.union(
          v.object({
            primitive: v.union(
              v.literal("string"),
              v.literal("number"),
              v.literal("boolean")
            ),
          }),
          v.object({ fields: v.record(v.string(), v.string()) }),
          v.object({ elementType: v.string() })
        ),
        required: v.boolean(),
      })
    ),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query123 = query({
  args: {
    i: v.union(
      v.object({
        type: v.literal("text"),
        content: v.string(),
        formatting: v.optional(
          v.object({
            bold: v.boolean(),
            italic: v.boolean(),
            color: v.union(
              v.literal("red"),
              v.literal("blue"),
              v.literal("green")
            ),
          })
        ),
      }),
      v.object({
        type: v.literal("image"),
        url: v.string(),
        alt: v.optional(v.string()),
        dimensions: v.object({
          width: v.number(),
          height: v.number(),
        }),
      }),
      v.object({
        type: v.literal("list"),
        items: v.array(v.string()),
        ordered: v.boolean(),
      })
    ),
  },
  returns: {
    i: v.union(
      v.object({
        type: v.literal("text"),
        content: v.string(),
        formatting: v.optional(
          v.object({
            bold: v.boolean(),
            italic: v.boolean(),
            color: v.union(
              v.literal("red"),
              v.literal("blue"),
              v.literal("green")
            ),
          })
        ),
      }),
      v.object({
        type: v.literal("image"),
        url: v.string(),
        alt: v.optional(v.string()),
        dimensions: v.object({
          width: v.number(),
          height: v.number(),
        }),
      }),
      v.object({
        type: v.literal("list"),
        items: v.array(v.string()),
        ordered: v.boolean(),
      })
    ),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query124 = query({
  args: {
    i: v.object({
      api: v.object({
        endpoints: v.record(
          v.string(),
          v.object({
            method: v.union(
              v.literal("GET"),
              v.literal("POST"),
              v.literal("PUT"),
              v.literal("DELETE")
            ),
            path: v.string(),
            auth: v.optional(v.boolean()),
            params: v.record(
              v.string(),
              v.union(v.string(), v.number(), v.boolean())
            ),
            response: v.any(),
          })
        ),
        rateLimit: v.object({
          requests: v.number(),
          window: v.union(
            v.literal("minute"),
            v.literal("hour"),
            v.literal("day")
          ),
        }),
      }),
      database: v.object({
        tables: v.record(
          v.string(),
          v.object({
            schema: v.record(
              v.string(),
              v.union(
                v.literal("string"),
                v.literal("number"),
                v.literal("boolean"),
                v.literal("date")
              )
            ),
            indexes: v.array(
              v.object({
                name: v.string(),
                fields: v.array(v.string()),
                unique: v.boolean(),
              })
            ),
          })
        ),
      }),
    }),
  },
  returns: {
    i: v.object({
      api: v.object({
        endpoints: v.record(
          v.string(),
          v.object({
            method: v.union(
              v.literal("GET"),
              v.literal("POST"),
              v.literal("PUT"),
              v.literal("DELETE")
            ),
            path: v.string(),
            auth: v.optional(v.boolean()),
            params: v.record(
              v.string(),
              v.union(v.string(), v.number(), v.boolean())
            ),
            response: v.any(),
          })
        ),
        rateLimit: v.object({
          requests: v.number(),
          window: v.union(
            v.literal("minute"),
            v.literal("hour"),
            v.literal("day")
          ),
        }),
      }),
      database: v.object({
        tables: v.record(
          v.string(),
          v.object({
            schema: v.record(
              v.string(),
              v.union(
                v.literal("string"),
                v.literal("number"),
                v.literal("boolean"),
                v.literal("date")
              )
            ),
            indexes: v.array(
              v.object({
                name: v.string(),
                fields: v.array(v.string()),
                unique: v.boolean(),
              })
            ),
          })
        ),
      }),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query125 = query({
  args: {
    i: v.object({
      workflow: v.object({
        steps: v.array(
          v.object({
            id: v.string(),
            name: v.string(),
            type: v.union(
              v.literal("action"),
              v.literal("condition"),
              v.literal("loop")
            ),
            config: v.record(v.string(), v.any()),
            next: v.optional(v.string()),
            error: v.optional(
              v.object({
                handler: v.string(),
                retry: v.object({
                  count: v.number(),
                  delay: v.number(),
                }),
              })
            ),
          })
        ),
        variables: v.record(
          v.string(),
          v.union(v.string(), v.number(), v.boolean(), v.array(v.any()))
        ),
        triggers: v.array(
          v.union(
            v.object({ type: v.literal("schedule"), cron: v.string() }),
            v.object({ type: v.literal("webhook"), url: v.string() }),
            v.object({ type: v.literal("event"), eventType: v.string() })
          )
        ),
      }),
    }),
  },
  returns: {
    i: v.object({
      workflow: v.object({
        steps: v.array(
          v.object({
            id: v.string(),
            name: v.string(),
            type: v.union(
              v.literal("action"),
              v.literal("condition"),
              v.literal("loop")
            ),
            config: v.record(v.string(), v.any()),
            next: v.optional(v.string()),
            error: v.optional(
              v.object({
                handler: v.string(),
                retry: v.object({
                  count: v.number(),
                  delay: v.number(),
                }),
              })
            ),
          })
        ),
        variables: v.record(
          v.string(),
          v.union(v.string(), v.number(), v.boolean(), v.array(v.any()))
        ),
        triggers: v.array(
          v.union(
            v.object({ type: v.literal("schedule"), cron: v.string() }),
            v.object({ type: v.literal("webhook"), url: v.string() }),
            v.object({ type: v.literal("event"), eventType: v.string() })
          )
        ),
      }),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Test queries to isolate query125 hanging issues

// Test 1: Simple Union3 with literals (similar to query125's step type)
export const query126 = query({
  args: {
    i: v.object({
      stepType: v.union(
        v.literal("action"),
        v.literal("condition"),
        v.literal("loop")
      ),
    }),
  },
  returns: {
    i: v.object({
      stepType: v.union(
        v.literal("action"),
        v.literal("condition"),
        v.literal("loop")
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Test 2: Union4 with List<dynamic> (query125's variables field)
export const query127 = query({
  args: {
    i: v.object({
      variables: v.record(
        v.string(),
        v.union(v.string(), v.number(), v.boolean(), v.array(v.any()))
      ),
    }),
  },
  returns: {
    i: v.object({
      variables: v.record(
        v.string(),
        v.union(v.string(), v.number(), v.boolean(), v.array(v.any()))
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Test 3: List of Union3 (query125's triggers field)
export const query128 = query({
  args: {
    i: v.object({
      triggers: v.array(
        v.union(
          v.object({ type: v.literal("schedule"), cron: v.string() }),
          v.object({ type: v.literal("webhook"), url: v.string() }),
          v.object({ type: v.literal("event"), eventType: v.string() })
        )
      ),
    }),
  },
  returns: {
    i: v.object({
      triggers: v.array(
        v.union(
          v.object({ type: v.literal("schedule"), cron: v.string() }),
          v.object({ type: v.literal("webhook"), url: v.string() }),
          v.object({ type: v.literal("event"), eventType: v.string() })
        )
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Test 4: Optional nested object (query125's error field)
export const query129 = query({
  args: {
    i: v.object({
      error: v.optional(
        v.object({
          handler: v.string(),
          retry: v.object({
            count: v.number(),
            delay: v.number(),
          }),
        })
      ),
    }),
  },
  returns: {
    i: v.object({
      error: v.optional(
        v.object({
          handler: v.string(),
          retry: v.object({
            count: v.number(),
            delay: v.number(),
          }),
        })
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Test 5: Complex nested array of objects (query125's steps field structure)
export const query130 = query({
  args: {
    i: v.object({
      steps: v.array(
        v.object({
          id: v.string(),
          name: v.string(),
          config: v.record(v.string(), v.any()),
          next: v.optional(v.string()),
        })
      ),
    }),
  },
  returns: {
    i: v.object({
      steps: v.array(
        v.object({
          id: v.string(),
          name: v.string(),
          config: v.record(v.string(), v.any()),
          next: v.optional(v.string()),
        })
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Test 6: ALL problematic features combined (minimal reproduction of query125 issue)
export const query131 = query({
  args: {
    i: v.object({
      steps: v.array(
        v.object({
          type: v.union(
            v.literal("action"),
            v.literal("condition"),
            v.literal("loop")
          ),
          error: v.optional(
            v.object({
              handler: v.string(),
              retry: v.object({
                count: v.number(),
                delay: v.number(),
              }),
            })
          ),
        })
      ),
      triggers: v.array(
        v.union(
          v.object({ type: v.literal("schedule"), cron: v.string() }),
          v.object({ type: v.literal("webhook"), url: v.string() }),
          v.object({ type: v.literal("event"), eventType: v.string() })
        )
      ),
      variables: v.record(
        v.string(),
        v.union(v.string(), v.number(), v.boolean(), v.array(v.any()))
      ),
    }),
  },
  returns: {
    i: v.object({
      steps: v.array(
        v.object({
          type: v.union(
            v.literal("action"),
            v.literal("condition"),
            v.literal("loop")
          ),
          error: v.optional(
            v.object({
              handler: v.string(),
              retry: v.object({
                count: v.number(),
                delay: v.number(),
              }),
            })
          ),
        })
      ),
      triggers: v.array(
        v.union(
          v.object({ type: v.literal("schedule"), cron: v.string() }),
          v.object({ type: v.literal("webhook"), url: v.string() }),
          v.object({ type: v.literal("event"), eventType: v.string() })
        )
      ),
      variables: v.record(
        v.string(),
        v.union(v.string(), v.number(), v.boolean(), v.array(v.any()))
      ),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query132 = query({
  args: {
    i: v.object({
      a: v.array(v.object({ b: v.string() })),
    }),
  },
  returns: {
    i: v.object({
      a: v.array(v.object({ b: v.string() })),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query133 = query({
  args: {
    i: v.object({
      a: v.optional(v.record(v.string(), v.number())),
    }),
  },
  returns: {
    i: v.object({
      a: v.optional(v.record(v.string(), v.number())),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query134 = query({
  args: {
    i: v.object({
      a: v.union(v.string(), v.array(v.boolean())),
    }),
  },
  returns: {
    i: v.object({
      a: v.union(v.string(), v.array(v.boolean())),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// More Complex Arrays
export const query135 = query({
  args: {
    i: v.array(v.object({ a: v.string(), b: v.optional(v.number()) })),
  },
  returns: {
    i: v.array(v.object({ a: v.string(), b: v.optional(v.number()) })),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// More Complex Unions
export const query137 = query({
  args: {
    i: v.union(
      v.object({ type: v.literal("A"), a: v.string() }),
      v.object({ type: v.literal("B"), b: v.number() })
    ),
  },
  returns: {
    i: v.union(
      v.object({ type: v.literal("A"), a: v.string() }),
      v.object({ type: v.literal("B"), b: v.number() })
    ),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query138 = query({
  args: {
    i: v.union(v.array(v.string()), v.record(v.string(), v.number())),
  },
  returns: {
    i: v.union(v.array(v.string()), v.record(v.string(), v.number())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// More Complex Records
export const query139 = query({
  args: {
    i: v.record(v.string(), v.object({ a: v.array(v.any()) })),
  },
  returns: {
    i: v.record(v.string(), v.object({ a: v.array(v.any()) })),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Deeply Nested Structures
export const query141 = query({
  args: {
    i: v.object({
      a: v.object({
        b: v.object({
          c: v.array(v.object({ d: v.string() })),
        }),
      }),
    }),
  },
  returns: {
    i: v.object({
      a: v.object({
        b: v.object({
          c: v.array(v.object({ d: v.string() })),
        }),
      }),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Multiple Arguments
export const query144 = query({
  args: {
    arg1: v.string(),
    arg2: v.number(),
    arg3: v.boolean(),
  },
  returns: v.object({
    arg1: v.string(),
    arg2: v.number(),
    arg3: v.boolean(),
  }),
  handler: (ctx, args) => {
    return args;
  },
});

export const query146 = query({
  args: {
    i: v.object({
      data: v.bytes(),
      metadata: v.optional(v.any()),
    }),
  },
  returns: {
    i: v.object({
      data: v.bytes(),
      metadata: v.optional(v.any()),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// Continue generating more random functions...

export const query148 = query({
  args: {
    i: v.record(v.string(), v.array(v.id("items"))),
  },
  returns: {
    i: v.record(v.string(), v.array(v.id("items"))),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query149 = query({
  args: {
    i: v.object({
      a: v.literal("foo"),
      b: v.literal(123),
      c: v.literal(false),
    }),
  },
  returns: {
    i: v.object({
      a: v.literal("foo"),
      b: v.literal(123),
      c: v.literal(false),
    }),
  },
  handler: (ctx, args) => {
    return args;
  },
});

export const query150 = query({
  args: {
    i: v.array(v.union(v.string(), v.number(), v.boolean())),
  },
  returns: {
    i: v.array(v.union(v.string(), v.number(), v.boolean())),
  },
  handler: (ctx, args) => {
    return args;
  },
});

// ... up to query331

// Let's generate a large batch of varied functions
// This is a simplified generation process for brevity.
// In a real scenario, you might use a script to generate these.

// ... starting from 151
export const query151 = query({
  args: { i: v.object({ a: v.array(v.int64()) }) },
  returns: { i: v.object({ a: v.array(v.int64()) }) },
  handler: (ctx, args) => args,
});
export const query152 = query({
  args: { i: v.record(v.string(), v.boolean()) },
  returns: { i: v.record(v.string(), v.boolean()) },
  handler: (ctx, args) => args,
});
export const query153 = query({
  args: { i: v.union(v.bytes(), v.string()) },
  returns: { i: v.union(v.bytes(), v.string()) },
  handler: (ctx, args) => args,
});
export const query154 = query({
  args: { i: v.array(v.literal("a")) },
  returns: { i: v.array(v.literal("a")) },
  handler: (ctx, args) => args,
});
export const query155 = query({
  args: { i: v.optional(v.id("users")) },
  returns: { i: v.optional(v.id("users")) },
  handler: (ctx, args) => args,
});
export const query156 = query({
  args: { i: v.any() },
  returns: { i: v.any() },
  handler: (ctx, args) => args,
});
export const query157 = query({
  args: { i: v.record(v.string(), v.any()) },
  returns: { i: v.record(v.string(), v.any()) },
  handler: (ctx, args) => args,
});
export const query158 = query({
  args: { i: v.object({ a: v.string(), b: v.number() }) },
  returns: { i: v.object({ a: v.string(), b: v.number() }) },
  handler: (ctx, args) => args,
});
export const query159 = query({
  args: { i: v.union(v.literal(1), v.literal(2)) },
  returns: { i: v.union(v.literal(1), v.literal(2)) },
  handler: (ctx, args) => args,
});

// ... continue this pattern with variations
export const query161 = query({
  args: { i: v.object({ a: v.optional(v.string()) }) },
  returns: { i: v.object({ a: v.optional(v.string()) }) },
  handler: (ctx, args) => args,
});

export const query163 = query({
  args: { i: v.union(v.id("a"), v.id("b")) },
  returns: { i: v.union(v.id("a"), v.id("b")) },
  handler: (ctx, args) => args,
});
export const query164 = query({
  args: { i: v.array(v.bytes()) },
  returns: { i: v.array(v.bytes()) },
  handler: (ctx, args) => args,
});
export const query165 = query({
  args: { i: v.optional(v.any()) },
  returns: { i: v.optional(v.any()) },
  handler: (ctx, args) => args,
});
export const query166 = query({
  args: { i: v.object({ a: v.object({ b: v.boolean() }) }) },
  returns: { i: v.object({ a: v.object({ b: v.boolean() }) }) },
  handler: (ctx, args) => args,
});
export const query167 = query({
  args: { i: v.record(v.string(), v.id("posts")) },
  returns: { i: v.record(v.string(), v.id("posts")) },
  handler: (ctx, args) => args,
});
export const query168 = query({
  args: { i: v.union(v.string(), v.null()) },
  returns: { i: v.union(v.string(), v.null()) },
  handler: (ctx, args) => args,
});
export const query169 = query({
  args: { i: v.array(v.array(v.string())) },
  returns: { i: v.array(v.array(v.string())) },
  handler: (ctx, args) => args,
});
export const query170 = query({
  args: { i: v.literal("hello world") },
  returns: { i: v.literal("hello world") },
  handler: (ctx, args) => args,
});
export const query171 = query({
  args: {
    i: v.object({
      a: v.string(),
      b: v.optional(v.number()),
      c: v.array(v.boolean()),
    }),
  },
  returns: {
    i: v.object({
      a: v.string(),
      b: v.optional(v.number()),
      c: v.array(v.boolean()),
    }),
  },
  handler: (ctx, args) => args,
});
export const query172 = query({
  args: {
    i: v.record(v.string(), v.union(v.string(), v.number())),
  },
  returns: {
    i: v.record(v.string(), v.union(v.string(), v.number())),
  },
  handler: (ctx, args) => args,
});
export const query173 = query({
  args: {
    i: v.union(
      v.object({ type: v.literal("A") }),
      v.object({ type: v.literal("B") })
    ),
  },
  returns: {
    i: v.union(
      v.object({ type: v.literal("A") }),
      v.object({ type: v.literal("B") })
    ),
  },
  handler: (ctx, args) => args,
});
export const query174 = query({
  args: { i: v.array(v.any()) },
  returns: { i: v.array(v.any()) },
  handler: (ctx, args) => args,
});
export const query175 = query({
  args: { i: v.optional(v.bytes()) },
  returns: { i: v.optional(v.bytes()) },
  handler: (ctx, args) => args,
});
export const query176 = query({
  args: {
    i: v.object({
      metadata: v.record(v.string(), v.object({ lastUpdated: v.number() })),
    }),
  },
  returns: {
    i: v.object({
      metadata: v.record(v.string(), v.object({ lastUpdated: v.number() })),
    }),
  },
  handler: (ctx, args) => args,
});
export const query177 = query({
  args: { i: v.record(v.string(), v.int64()) },
  returns: { i: v.record(v.string(), v.int64()) },
  handler: (ctx, args) => args,
});
export const query178 = query({
  args: {
    i: v.union(v.array(v.string()), v.array(v.number())),
  },
  returns: {
    i: v.union(v.array(v.string()), v.array(v.number())),
  },
  handler: (ctx, args) => args,
});
export const query179 = query({
  args: { i: v.array(v.id("messages")) },
  returns: { i: v.array(v.id("messages")) },
  handler: (ctx, args) => args,
});
export const query180 = query({
  args: { i: v.literal(3.14) },
  returns: { i: v.literal(3.14) },
  handler: (ctx, args) => args,
});
export const query181 = query({
  args: {
    i: v.object({
      deeply: v.object({ nested: v.object({ value: v.string() }) }),
    }),
  },
  returns: {
    i: v.object({
      deeply: v.object({ nested: v.object({ value: v.string() }) }),
    }),
  },
  handler: (ctx, args) => args,
});

export const query183 = query({
  args: {
    i: v.union(v.object({ a: v.string() }), v.object({ a: v.number() })),
  },
  returns: {
    i: v.union(v.object({ a: v.string() }), v.object({ a: v.number() })),
  },
  handler: (ctx, args) => args,
});
export const query184 = query({
  args: { i: v.array(v.record(v.string(), v.boolean())) },
  returns: {
    i: v.array(v.record(v.string(), v.boolean())),
  },
  handler: (ctx, args) => args,
});
export const query185 = query({
  args: { i: v.optional(v.literal("on")) },
  returns: { i: v.optional(v.literal("on")) },
  handler: (ctx, args) => args,
});
export const query186 = query({
  args: {
    i: v.object({
      permissions: v.array(
        v.union(v.literal("read"), v.literal("write"), v.literal("admin"))
      ),
    }),
  },
  returns: {
    i: v.object({
      permissions: v.array(
        v.union(v.literal("read"), v.literal("write"), v.literal("admin"))
      ),
    }),
  },
  handler: (ctx, args) => args,
});
export const query187 = query({
  args: {
    i: v.record(v.string(), v.record(v.string(), v.string())),
  },
  returns: {
    i: v.record(v.string(), v.record(v.string(), v.string())),
  },
  handler: (ctx, args) => args,
});
export const query188 = query({
  args: {
    i: v.union(v.any(), v.id("fallback")),
  },
  returns: {
    i: v.union(v.any(), v.id("fallback")),
  },
  handler: (ctx, args) => args,
});
export const query189 = query({
  args: {
    i: v.array(
      v.object({ id: v.id("nodes"), children: v.array(v.id("nodes")) })
    ),
  },
  returns: {
    i: v.array(
      v.object({ id: v.id("nodes"), children: v.array(v.id("nodes")) })
    ),
  },
  handler: (ctx, args) => args,
});
export const query190 = query({
  args: { i: v.literal(true) },
  returns: { i: v.literal(true) },
  handler: (ctx, args) => args,
});

// ... and so on, until 331. The following are more examples.
export const query191 = query({
  args: { i: v.id("another_table") },
  returns: { i: v.id("another_table") },
  handler: (ctx, args) => args,
});
export const query192 = query({
  args: { i: v.int64() },
  returns: { i: v.int64() },
  handler: (ctx, args) => args,
});
export const query193 = query({
  args: { i: v.bytes() },
  returns: { i: v.bytes() },
  handler: (ctx, args) => args,
});
export const query194 = query({
  args: { i: v.optional(v.boolean()) },
  returns: { i: v.optional(v.boolean()) },
  handler: (ctx, args) => args,
});
export const query195 = query({
  args: { i: v.union(v.number(), v.null()) },
  returns: { i: v.union(v.number(), v.null()) },
  handler: (ctx, args) => args,
});
export const query196 = query({
  args: { i: v.array(v.string()) },
  returns: { i: v.array(v.string()) },
  handler: (ctx, args) => args,
});
export const query197 = query({
  args: { i: v.record(v.string(), v.number()) },
  returns: { i: v.record(v.string(), v.number()) },
  handler: (ctx, args) => args,
});
export const query198 = query({
  args: { i: v.object({ name: v.string(), value: v.any() }) },
  returns: { i: v.object({ name: v.string(), value: v.any() }) },
  handler: (ctx, args) => args,
});
export const query199 = query({
  args: { i: v.union(v.literal("A"), v.literal("B"), v.literal("C")) },
  returns: { i: v.union(v.literal("A"), v.literal("B"), v.literal("C")) },
  handler: (ctx, args) => args,
});

export const query201 = query({
  args: { i: v.object({ a: v.string(), b: v.string() }) },
  returns: { i: v.object({ a: v.string(), b: v.string() }) },
  handler: (ctx, args) => args,
});

export const query203 = query({
  args: { i: v.union(v.string(), v.number()) },
  returns: { i: v.union(v.string(), v.number()) },
  handler: (ctx, args) => args,
});
export const query204 = query({
  args: { i: v.array(v.int64()) },
  returns: { i: v.array(v.int64()) },
  handler: (ctx, args) => args,
});
export const query205 = query({
  args: { i: v.optional(v.record(v.string(), v.string())) },
  returns: { i: v.optional(v.record(v.string(), v.string())) },
  handler: (ctx, args) => args,
});
export const query206 = query({
  args: { i: v.object({ data: v.array(v.object({ value: v.number() })) }) },
  returns: { i: v.object({ data: v.array(v.object({ value: v.number() })) }) },
  handler: (ctx, args) => args,
});

export const query208 = query({
  args: { i: v.union(v.literal("on"), v.literal("off")) },
  returns: { i: v.union(v.literal("on"), v.literal("off")) },
  handler: (ctx, args) => args,
});
export const query209 = query({
  args: { i: v.array(v.union(v.string(), v.null())) },
  returns: { i: v.array(v.union(v.string(), v.null())) },
  handler: (ctx, args) => args,
});
export const query210 = query({
  args: { i: v.literal(-1) },
  returns: { i: v.literal(-1) },
  handler: (ctx, args) => args,
});
// ... Keep generating with diverse combinations...
export const query211 = query({
  args: { i: v.object({ tags: v.array(v.string()) }) },
  returns: { i: v.object({ tags: v.array(v.string()) }) },
  handler: (ctx, args) => args,
});
export const query212 = query({
  args: { i: v.record(v.string(), v.array(v.any())) },
  returns: { i: v.record(v.string(), v.array(v.any())) },
  handler: (ctx, args) => args,
});
export const query213 = query({
  args: { i: v.union(v.id("users"), v.id("admins")) },
  returns: { i: v.union(v.id("users"), v.id("admins")) },
  handler: (ctx, args) => args,
});
export const query214 = query({
  args: { i: v.array(v.object({ id: v.string(), score: v.number() })) },
  returns: { i: v.array(v.object({ id: v.string(), score: v.number() })) },
  handler: (ctx, args) => args,
});
export const query215 = query({
  args: { i: v.optional(v.array(v.boolean())) },
  returns: { i: v.optional(v.array(v.boolean())) },
  handler: (ctx, args) => args,
});
export const query216 = query({
  args: { i: v.object({ payload: v.any(), timestamp: v.number() }) },
  returns: { i: v.object({ payload: v.any(), timestamp: v.number() }) },
  handler: (ctx, args) => args,
});
export const query217 = query({
  args: { i: v.record(v.string(), v.literal("value")) },
  returns: { i: v.record(v.string(), v.literal("value")) },
  handler: (ctx, args) => args,
});
export const query218 = query({
  args: {
    i: v.union(
      v.object({ success: v.literal(true), data: v.any() }),
      v.object({ success: v.literal(false), error: v.string() })
    ),
  },
  returns: {
    i: v.union(
      v.object({ success: v.literal(true), data: v.any() }),
      v.object({ success: v.literal(false), error: v.string() })
    ),
  },
  handler: (ctx, args) => args,
});
export const query219 = query({
  args: { i: v.array(v.record(v.string(), v.any())) },
  returns: { i: v.array(v.record(v.string(), v.any())) },
  handler: (ctx, args) => args,
});
export const query220 = query({
  args: { i: v.literal("") },
  returns: { i: v.literal("") },
  handler: (ctx, args) => args,
});
// ... 111 more to go
export const query221 = query({
  args: { i: v.object({ a: v.optional(v.object({ b: v.string() })) }) },
  returns: { i: v.object({ a: v.optional(v.object({ b: v.string() })) }) },
  handler: (ctx, args) => args,
});

export const query223 = query({
  args: { i: v.union(v.int64(), v.bytes()) },
  returns: { i: v.union(v.int64(), v.bytes()) },
  handler: (ctx, args) => args,
});
export const query224 = query({
  args: { i: v.array(v.union(v.literal("cat"), v.literal("dog"))) },
  returns: { i: v.array(v.union(v.literal("cat"), v.literal("dog"))) },
  handler: (ctx, args) => args,
});
export const query225 = query({
  args: { i: v.optional(v.union(v.string(), v.number())) },
  returns: { i: v.optional(v.union(v.string(), v.number())) },
  handler: (ctx, args) => args,
});
