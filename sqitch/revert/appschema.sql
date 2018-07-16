-- Revert magic-inventory:appschema from pg

BEGIN;

DROP SCHEMA magic_inventory CASCADE;

DROP SCHEMA magic_inventory_private CASCADE;

COMMIT;
