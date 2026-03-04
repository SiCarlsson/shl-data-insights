-- Initial schema: schemas, tables, grants and RLS
BEGIN;

-- Create schemas
CREATE SCHEMA IF NOT EXISTS bronze;

CREATE SCHEMA IF NOT EXISTS silver;

CREATE SCHEMA IF NOT EXISTS reference;

-- Grant schema access
GRANT USAGE ON SCHEMA bronze TO anon,
authenticated,
service_role;

GRANT USAGE ON SCHEMA silver TO anon,
authenticated,
service_role;

GRANT USAGE ON SCHEMA reference TO anon,
authenticated,
service_role;

-- Grant table permissions
GRANT ALL ON ALL TABLES IN SCHEMA bronze TO anon,
authenticated,
service_role;

GRANT ALL ON ALL TABLES IN SCHEMA silver TO anon,
authenticated,
service_role;

GRANT ALL ON ALL TABLES IN SCHEMA reference TO anon,
authenticated,
service_role;

-- Grant sequence permissions
GRANT ALL ON ALL SEQUENCES IN SCHEMA bronze TO anon,
authenticated,
service_role;

GRANT ALL ON ALL SEQUENCES IN SCHEMA silver TO anon,
authenticated,
service_role;

GRANT ALL ON ALL SEQUENCES IN SCHEMA reference TO anon,
authenticated,
service_role;

-- Automatically apply grants to future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA bronze GRANT ALL ON TABLES TO anon,
authenticated,
service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA bronze GRANT ALL ON SEQUENCES TO anon,
authenticated,
service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA silver GRANT ALL ON TABLES TO anon,
authenticated,
service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA silver GRANT ALL ON SEQUENCES TO anon,
authenticated,
service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT ALL ON TABLES TO anon,
authenticated,
service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA reference GRANT ALL ON SEQUENCES TO anon,
authenticated,
service_role;

-- Silver tables
CREATE TABLE
IF NOT EXISTS silver.shl_teams (
    team_id serial,
    team_uuid character varying(50) NOT NULL,
    full_name character varying(40) NOT NULL,
    long_name character varying(40) NOT NULL,
    short_name character varying(20) NOT NULL,
    code character varying(4) NOT NULL,
    icon_url text,
    is_active boolean NOT NULL DEFAULT TRUE,
    PRIMARY KEY (team_id),
    UNIQUE (team_uuid)
);

CREATE TABLE
IF NOT EXISTS silver.shl_players (
    player_id serial,
    player_uuid character varying(50) NOT NULL,
    team_id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    full_name character varying(60),
    gender character varying(10),
    jersey_number integer NOT NULL,
    date_of_birth date NOT NULL,
    nationality character varying(2) NOT NULL,
    position character varying(20) NOT NULL,
    position_code character varying(2),
    shoots character varying(1),
    height_cm integer,
    weight_kg integer,
    valid_from date NOT NULL,
    valid_to date,
    is_current boolean NOT NULL DEFAULT TRUE,
    roster_status character varying(20) NOT NULL DEFAULT 'roster',
    portrait_url text,
    PRIMARY KEY (player_id),
    UNIQUE (player_uuid, valid_from)
);

CREATE TABLE
IF NOT EXISTS silver.shl_games (
    game_id serial,
    game_uuid character varying(50) NOT NULL,
    season_uuid character varying(50) NOT NULL,
    series_uuid character varying(50) NOT NULL,
    game_type_uuid character varying(50) NOT NULL,
    home_team_id integer NOT NULL,
    away_team_id integer NOT NULL,
    home_score integer,
    away_score integer,
    game_date timestamp
    with
    time zone NOT NULL,
    game_state character varying(20) NOT NULL,
    overtime boolean NOT NULL DEFAULT FALSE,
    shootout boolean NOT NULL DEFAULT FALSE,
    venue_name character varying(100),
    venue_uuid character varying(50),
    PRIMARY KEY (game_id),
    UNIQUE (game_uuid)
);

-- Bronze tables
CREATE TABLE
IF NOT EXISTS bronze.shl_game_schedule (
    id serial,
    season_uuid character varying(50) NOT NULL,
    raw_data jsonb NOT NULL,
    loaded_at timestamp
    with
    time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE
IF NOT EXISTS bronze.shl_team_roster (
    id serial,
    team_uuid character varying(50) NOT NULL,
    raw_data jsonb NOT NULL,
    loaded_at timestamp
    with
    time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE
IF NOT EXISTS bronze.shl_team_info (
    id serial,
    team_uuid character varying(50) NOT NULL,
    raw_data jsonb NOT NULL,
    loaded_at timestamp
    with
    time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE
IF NOT EXISTS bronze.shl_player_stats (
    id serial,
    team_uuid character varying(50) NOT NULL,
    raw_data jsonb NOT NULL,
    loaded_at timestamp
    with
    time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE
IF NOT EXISTS bronze.shl_metadata (
    id serial,
    raw_data jsonb NOT NULL,
    loaded_at timestamp
    with
    time zone NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

-- Reference tables
CREATE TABLE
IF NOT EXISTS reference.seasons (
    season_id serial,
    season_uuid character varying(50) NOT NULL,
    code character varying(15) NOT NULL,
    name character varying(50) NOT NULL,
    is_current boolean DEFAULT FALSE,
    created_at timestamp
    with
    time zone DEFAULT NOW(),
    updated_at timestamp
    with
    time zone DEFAULT NOW(),
    PRIMARY KEY (season_id),
    UNIQUE (season_uuid)
);

CREATE TABLE
IF NOT EXISTS reference.game_types (
    game_type_id serial,
    game_type_uuid character varying(50) NOT NULL,
    code character varying(20) NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp
    with
    time zone DEFAULT NOW(),
    updated_at timestamp
    with
    time zone DEFAULT NOW(),
    PRIMARY KEY (game_type_id)
);

CREATE TABLE
IF NOT EXISTS reference.series (
    series_id serial,
    series_uuid character varying(50) NOT NULL,
    code character varying(20) NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp
    with
    time zone DEFAULT NOW(),
    updated_at timestamp
    with
    time zone DEFAULT NOW(),
    PRIMARY KEY (series_id)
);

-- Foreign keys
ALTER TABLE IF EXISTS silver.shl_players ADD FOREIGN KEY (team_id) REFERENCES silver.shl_teams (
    team_id
) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE IF EXISTS silver.shl_games ADD FOREIGN KEY (home_team_id) REFERENCES silver.shl_teams (
    team_id
) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE IF EXISTS silver.shl_games ADD FOREIGN KEY (away_team_id) REFERENCES silver.shl_teams (
    team_id
) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE IF EXISTS silver.shl_games ADD FOREIGN KEY (season_uuid) REFERENCES reference.seasons (
    season_uuid
) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION NOT VALID;

ALTER TABLE IF EXISTS silver.shl_games ADD FOREIGN KEY (series_uuid) REFERENCES reference.series (
    series_uuid
) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION NOT VALID;

ALTER TABLE IF EXISTS silver.shl_games ADD FOREIGN KEY (game_type_uuid) REFERENCES reference.game_types (
    game_type_uuid
) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION NOT VALID;

-- Enable RLS on bronze tables
ALTER TABLE bronze.shl_metadata ENABLE ROW LEVEL SECURITY;

ALTER TABLE bronze.shl_game_schedule ENABLE ROW LEVEL SECURITY;

ALTER TABLE bronze.shl_team_roster ENABLE ROW LEVEL SECURITY;

ALTER TABLE bronze.shl_team_info ENABLE ROW LEVEL SECURITY;

ALTER TABLE bronze.shl_player_stats ENABLE ROW LEVEL SECURITY;

-- Enable RLS on silver tables
ALTER TABLE silver.shl_teams ENABLE ROW LEVEL SECURITY;

ALTER TABLE silver.shl_players ENABLE ROW LEVEL SECURITY;

ALTER TABLE silver.shl_games ENABLE ROW LEVEL SECURITY;

-- Enable RLS on reference tables
ALTER TABLE reference.seasons ENABLE ROW LEVEL SECURITY;

ALTER TABLE reference.series ENABLE ROW LEVEL SECURITY;

ALTER TABLE reference.game_types ENABLE ROW LEVEL SECURITY;

END;
