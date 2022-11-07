import { defineConfig } from "vite";
import { resolve } from "path";

export default defineConfig({
  resolve: {
    alias: {
      "@list": resolve("src/list"),
      "@list/*": resolve("src/list/*"),
      "@string": resolve("src/string"),
      "@string/*": resolve("src/string/*"),
    },
  },
});
