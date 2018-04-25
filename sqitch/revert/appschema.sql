-- Revert magic-inventory:appschema from pg

BEGIN;

DROP SCHEMA magic_inventory CASCADE;

COMMIT;
