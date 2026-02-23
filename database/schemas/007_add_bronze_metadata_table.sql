-- =============================================================================
-- Fantasy SHL Data Insights - Add Bronze Metadata Table
-- =============================================================================
-- Description: Adds bronze.shl_metadata table for raw season metadata storage
-- Author: Simon Carlsson
-- Created: 2026-02-23
-- Database: fantasy_sports_db
--
-- Changes:
-- - Add bronze.shl_metadata table
-- =============================================================================

BEGIN;

CREATE TABLE IF NOT EXISTS bronze.shl_metadata
(
    id serial,
    raw_data jsonb NOT NULL,
    loaded_at timestamp with time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

COMMIT;
