# SHL dbt project

This dbt project uses a repository-local profile file at `../profiles.yml`.

## Run with repo-local profile

From this directory (`dbt/shl_data_insights`), run:

- `dbt --profiles-dir .. debug --target dev`
- `dbt --profiles-dir .. run --target dev`
- `dbt --profiles-dir .. test --target dev`

Use Supabase for production:

- `dbt --profiles-dir .. debug --target prod`
- `dbt --profiles-dir .. run --target prod`
- `dbt --profiles-dir .. test --target prod`

## Required environment variables

- For `dev` (local), optional defaults are already set in `../profiles.yml`.
- For `prod` (Supabase), required:
	- `SUPABASE_DB_HOST`
	- `SUPABASE_DB_PASSWORD`

Optional (defaults exist in `../profiles.yml`):

- `SUPABASE_DB_PORT` (default `5432`)
- `SUPABASE_DB_USER` (default `postgres`)
- `SUPABASE_DB_NAME` (default `postgres`)
- `DBT_DEV_SCHEMA` (default `reference`)
- `DBT_PROD_SCHEMA` (default `reference`)
