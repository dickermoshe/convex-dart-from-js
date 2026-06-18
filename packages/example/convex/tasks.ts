import { Id } from "./_generated/dataModel";
import { query, mutation } from "./_generated/server";
import { v } from "convex/values";

// CREATE - Add a new task
export const createTask = mutation({
  args: {
    text: v.string(),
    isCompleted: v.optional(v.boolean()),
  },
  returns: v.id("tasks"),
  handler: async (ctx, args) => {
    const taskId = await ctx.db.insert("tasks", {
      text: args.text,
      isCompleted: args.isCompleted ?? false,
    });
    return taskId;
  },
});

// READ - Get all tasks
export const getAllTasks = query({
  returns: v.array(
    v.object({
      _id: v.id("tasks"),
      text: v.string(),
      isCompleted: v.boolean(),
      _creationTime: v.number(),
    })
  ),
  handler: async (ctx) => {
    return await ctx.db.query("tasks").collect();
  },
});

// READ - Get a single task by ID
export const getTask = query({
  args: {
    id: v.id("tasks"),
  },
  returns: v.union(
    v.object({
      _id: v.id("tasks"),
      text: v.string(),
      isCompleted: v.boolean(),
      _creationTime: v.number(),
    }),
    v.null()
  ),
  handler: async (ctx, args) => {
    return await ctx.db.get(args.id);
  },
});

// READ - Get tasks by completion status
export const getTasksByStatus = query({
  args: {
    isCompleted: v.boolean(),
  },
  returns: v.array(
    v.object({
      _id: v.id("tasks"),
      text: v.string(),
      isCompleted: v.boolean(),
      _creationTime: v.number(),
    })
  ),
  handler: async (ctx, args) => {
    return await ctx.db
      .query("tasks")
      .filter((q) => q.eq(q.field("isCompleted"), args.isCompleted))
      .collect();
  },
});

// READ - Search tasks by text content
export const searchTasks = query({
  args: {
    searchText: v.string(),
  },
  returns: v.array(
    v.object({
      _id: v.id("tasks"),
      text: v.string(),
      isCompleted: v.boolean(),
      _creationTime: v.number(),
    })
  ),
  handler: async (ctx, args) => {
    const tasks = await ctx.db.query("tasks").collect();
    return tasks.filter((task) =>
      task.text.toLowerCase().includes(args.searchText.toLowerCase())
    );
  },
});

// UPDATE - Update task text
export const updateTaskText = mutation({
  args: {
    id: v.id("tasks"),
    text: v.string(),
  },
  returns: v.null(),
  handler: async (ctx, args) => {
    await ctx.db.patch(args.id, {
      text: args.text,
    });
  },
});

// UPDATE - Toggle task completion status
export const toggleTaskCompletion = mutation({
  args: {
    id: v.id("tasks"),
  },
  returns: v.boolean(),
  handler: async (ctx, args) => {
    const task = await ctx.db.get(args.id);
    if (!task) {
      throw new Error("Task not found");
    }

    const newStatus = !task.isCompleted;
    await ctx.db.patch(args.id, {
      isCompleted: newStatus,
    });

    return newStatus;
  },
});

// UPDATE - Set task completion status
export const setTaskCompletion = mutation({
  args: {
    id: v.id("tasks"),
    isCompleted: v.boolean(),
  },
  returns: v.null(),
  handler: async (ctx, args) => {
    await ctx.db.patch(args.id, {
      isCompleted: args.isCompleted,
    });
  },
});

// UPDATE - Update entire task
export const updateTask = mutation({
  args: {
    id: v.id("tasks"),
    text: v.optional(v.string()),
    isCompleted: v.optional(v.boolean()),
  },
  returns: v.null(),
  handler: async (ctx, args) => {
    const updates: any = {};

    if (args.text !== undefined) {
      updates.text = args.text;
    }

    if (args.isCompleted !== undefined) {
      updates.isCompleted = args.isCompleted;
    }

    if (Object.keys(updates).length > 0) {
      await ctx.db.patch(args.id, updates);
    }
  },
});

// DELETE - Delete a task by ID
export const deleteTask = mutation({
  args: {
    id: v.id("tasks"),
  },
  returns: v.null(),
  handler: async (ctx, args) => {
    await ctx.db.delete(args.id);
  },
});

// DELETE - Delete all completed tasks
export const deleteCompletedTasks = mutation({
  returns: v.number(),
  handler: async (ctx) => {
    const completedTasks = await ctx.db
      .query("tasks")
      .filter((q) => q.eq(q.field("isCompleted"), true))
      .collect();

    for (const task of completedTasks) {
      await ctx.db.delete(task._id);
    }

    return completedTasks.length;
  },
});

// DELETE - Delete all tasks
export const deleteAllTasks = mutation({
  returns: v.number(),
  handler: async (ctx) => {
    const allTasks = await ctx.db.query("tasks").collect();

    for (const task of allTasks) {
      await ctx.db.delete(task._id);
    }

    return allTasks.length;
  },
});

// UTILITY - Get task count
export const getTaskCount = query({
  returns: v.object({
    total: v.number(),
    completed: v.number(),
    pending: v.number(),
  }),
  handler: async (ctx) => {
    const allTasks = await ctx.db.query("tasks").collect();
    const completed = allTasks.filter((task) => task.isCompleted).length;
    const pending = allTasks.length - completed;

    return {
      total: allTasks.length,
      completed,
      pending,
    };
  },
});
