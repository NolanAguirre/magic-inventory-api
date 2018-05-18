-- Deploy magic-inventory:extensions to pg
-- requires: appschema

BEGIN;

CREATE EXTENSION citext;

CREATE EXTENSION "uuid-ossp";

COMMIT;
