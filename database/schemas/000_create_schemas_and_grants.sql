-- =============================================================================
-- Fantasy SHL Data Insights - Create Schemas and Grant Permissions
-- =============================================================================
-- Description: Creates all schemas and grants permissions to Supabase roles.
--              Must be run before all other migrations.
-- Author: Simon Carlsson
-- Created: 2026-02-23
-- Database: fantasy_sports_db
-- =============================================================================

BEGIN;

CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS reference;

-- Grant schema access
GRANT USAGE ON SCHEMA bronze TO anon, authenticated, service_role;
GRANT USAGE ON SCHEMA silver TO anon, authenticated, service_role;
GRANT USAGE ON SCHEMA reference TO anon, authenticated, service_role;

-- Grant table permissions
GRANT ALL ON ALL TABLES IN SCHEMA bronze TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA silver TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA reference TO anon, authenticated, service_role;

-- Grant sequence permissions (needed for serial/autoincrement columns)
GRANT ALL ON ALL SEQUENCES IN SCHEMA bronze TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA silver TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA reference TO anon, authenticated, service_role;

-- Automatically apply grants to future tables created in these schemas
ALTER DEFAULT PRIVILEGES IN SCHEMA bronze GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA bronze GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA silver GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA silver GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

-- Enable RLS on all bronze tables
ALTER TABLE bronze.shl_metadata ENABLE ROW LEVEL SECURITY;
ALTER TABLE bronze.shl_game_schedule ENABLE ROW LEVEL SECURITY;
ALTER TABLE bronze.shl_team_roster ENABLE ROW LEVEL SECURITY;
ALTER TABLE bronze.shl_team_info ENABLE ROW LEVEL SECURITY;
ALTER TABLE bronze.shl_player_stats ENABLE ROW LEVEL SECURITY;

-- Enable RLS on all silver tables
ALTER TABLE silver.shl_teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE silver.shl_players ENABLE ROW LEVEL SECURITY;
ALTER TABLE silver.shl_games ENABLE ROW LEVEL SECURITY;

-- Enable RLS on all reference tables
ALTER TABLE reference.seasons ENABLE ROW LEVEL SECURITY;
ALTER TABLE reference.series ENABLE ROW LEVEL SECURITY;
ALTER TABLE reference.game_types ENABLE ROW LEVEL SECURITY;

COMMIT;
