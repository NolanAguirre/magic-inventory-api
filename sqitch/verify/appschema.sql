-- Verify magic-inventory:appschema on pg

BEGIN;

SELECT 1/COUNT(*) FROM information_schema.schemata WHERE schema_name = 'magic_inventory';

ROLLBACK;
