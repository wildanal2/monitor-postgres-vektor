-- Create extension for vector operations
CREATE EXTENSION IF NOT EXISTS vector;

-- Optionally enable pg_stat_statements
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Grant access to pg_stat_statements for the postgres user
GRANT SELECT ON pg_stat_statements TO postgres;
