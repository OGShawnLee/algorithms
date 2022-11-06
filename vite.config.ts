import { defineConfig } from "vite";
import { resolve } from "path";

export default defineConfig({
  resolve: {
    alias: {
      "@string": resolve("src/string"),
      "@string/*": resolve("src/string/*"),
    },
  },
});
