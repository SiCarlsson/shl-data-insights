FROM postgres:17

# Copy schema files
COPY schemas/ /docker-entrypoint-initdb.d/

# Create bronze and silver schemas on initialization
RUN echo "CREATE SCHEMA IF NOT EXISTS bronze; CREATE SCHEMA IF NOT EXISTS silver;" > /docker-entrypoint-initdb.d/000_create_schemas.sql
