> ⚠️ **Under Construction** — This project is actively being developed.

# SHL Data Insights

Data pipeline and analytics platform for Swedish Hockey League (SHL) data, built to power fantasy hockey insights and statistics.

## Goal

Ingest, transform, and analyze SHL game and player data to provide actionable insights for fantasy hockey decisions.

## Architecture

- **API**: Next.js endpoints for data ingestion and querying
- **Database**: PostgreSQL with medallion architecture
- - **Bronze Layer**: Raw JSON data from SHL's undocumented API
- - **Silver Layer**: Normalized, typed data (planned)
- - **Gold Layer**: Aggregated analytics and metrics (planned)

## Tech Stack

- Next.js 16
- PostgreSQL 16
- TypeScript
- dbt
- Vitest
- Docker (local development only)

## Installation

Run the following to set up the complete development environment:

```bash
make create-dev
```

This will:

- Create a Python virtual environment and install all dependencies
- Install web dependencies via pnpm
- Set up pre-commit and pre-push hooks

<details>
<summary>Manual steps</summary>

**Python** (pipelines):

```bash
pip install -r requirements.txt
pip install -r requirements-dev.txt  # for dev dependencies
```

**Next.js** (`web/`):

```bash
cd web
pnpm install
```

**Git Hooks:**

```bash
pre-commit install
pre-commit install --hook-type pre-push
```

</details>
