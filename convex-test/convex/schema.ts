import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";

export default defineSchema({
  counters: defineTable({
    name: v.string(),
    value: v.int64(),
  }).index("by_name", ["name"]),
});
