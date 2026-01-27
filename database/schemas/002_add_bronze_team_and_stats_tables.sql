-- =============================================================================
-- Fantasy SHL Data Insights - Add Bronze Team and Stats Tables
-- =============================================================================
-- Description: Adds bronze layer tables for team info, roster, and player stats
-- Author: Simon Carlsson
-- Created: 2026-01-27
-- Database: fantasy_sports_db
--
-- Changes:
-- - Add bronze.shl_team_roster table
-- - Add bronze.shl_team_info table
-- - Add bronze.shl_player_stats table
-- - Remove bronze.shl_athletes table (replaced by shl_team_roster)
-- =============================================================================

BEGIN;

-- Add new bronze tables for team and player data
CREATE TABLE IF NOT EXISTS bronze.shl_team_roster
(
    id serial,
    team_uuid character varying(50) NOT NULL,
    raw_data jsonb NOT NULL,
    loaded_at timestamp with time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS bronze.shl_team_info
(
    id serial,
    team_uuid character varying(50) NOT NULL,
    raw_data jsonb NOT NULL,
    loaded_at timestamp with time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS bronze.shl_player_stats
(
    id serial,
    team_uuid character varying(50) NOT NULL,
    raw_data jsonb NOT NULL,
    loaded_at timestamp with time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

-- Remove deprecated table
DROP TABLE IF EXISTS bronze.shl_athletes;

END;