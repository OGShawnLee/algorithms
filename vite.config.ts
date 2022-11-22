import { defineConfig } from "vite";
import { resolve } from "path";

export default defineConfig({
  resolve: {
    alias: {
      "@data": resolve("src/data"),
      "@list": resolve("src/list"),
      "@list/*": resolve("src/list/*"),
      "@string": resolve("src/string"),
      "@string/*": resolve("src/string/*"),
      "@utils": resolve("src/utils"),
    },
  },
  test: {
    globals: true,
  },
});
