import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";
import nextTs from "eslint-config-next/typescript";

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTs,
  // Override default ignores of eslint-config-next.
  globalIgnores([
    // Default ignores of eslint-config-next:
    ".next/**",
    "out/**",
    "build/**",
    "next-env.d.ts",
  ]),
  {
    rules: {
      // Enforce consistent indentation of 2 spaces.
      indent: ["error", 2],
      // Disallow var
      "no-var": "error",
      // Require the use of === and !== instead of == and !=.
      eqeqeq: "error",
      // Disallow logging of console messages.
      "no-console": "error",
      // Enforce the use of `const` for variables that are never reassigned after declaration.
      "prefer-const": "error",
      // Disallow the use of `any` type in TypeScript.
      "@typescript-eslint/no-explicit-any": "error",
      // Disallow unused variables in TypeScript.
      "@typescript-eslint/no-unused-vars": "error",
      // Enforce consistent usage of type imports in TypeScript.
      "@typescript-eslint/consistent-type-imports": "error",
    },
  },
]);

export default eslintConfig;
