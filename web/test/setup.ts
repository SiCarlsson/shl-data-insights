import { resolve } from "path";
import { config } from "dotenv";
import { beforeAll, afterAll } from "vitest";

config({ path: resolve(__dirname, "../../.env") });

beforeAll(() => {
  // Environment variables are already loaded from .env
  // You can override specific test values here if needed
});

afterAll(() => {
  // Cleanup if needed
});
