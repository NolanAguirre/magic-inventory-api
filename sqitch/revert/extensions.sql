-- Revert magic-inventory:extensions from pg

BEGIN;

DROP EXTENSION citext;

COMMIT;
