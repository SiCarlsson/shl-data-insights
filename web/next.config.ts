import type { NextConfig } from "next";
import { config } from "dotenv";
import { resolve } from "path";
import createNextIntlPlugin from "next-intl/plugin";

const withNextIntl = createNextIntlPlugin();

// Load .env from parent directory
config({ path: resolve(__dirname, "../.env") });

const nextConfig: NextConfig = {
  env: {
    POSTGRES_HOST: process.env.POSTGRES_HOST,
    POSTGRES_PORT: process.env.POSTGRES_PORT,
    POSTGRES_DB: process.env.POSTGRES_DB,
    POSTGRES_USER: process.env.POSTGRES_USER,
    POSTGRES_PASSWORD: process.env.POSTGRES_PASSWORD,
  },
};

export default withNextIntl(nextConfig);
