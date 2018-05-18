-- Revert magic-inventory:extensions from pg

BEGIN;

DROP EXTENSION citext;

DROP EXTENSION "uuid-ossp";

COMMIT;
