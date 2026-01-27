# SHL Data Insights 

Data pipeline and analytics platform for Swedish Hockey League (SHL) data, built to power fantasy hockey insights and statistics.

## Goal
Ingest, transform, and analyze SHL game and player data to provide actionable insights for fantasy hockey decisions.

## Architecture
- **Bronze Layer**: Raw JSON data from SHL's undocumented API
- **Silver Layer**: Normalized, typed data (planned)
- **Gold Layer**: Aggregated analytics and metrics (planned)
- **API**: Next.js endpoints for data ingestion and querying
- **Database**: PostgreSQL with medallion architecture

## Tech Stack
Next.js 16, PostgreSQL 16, TypeScript, Vitest, Docker