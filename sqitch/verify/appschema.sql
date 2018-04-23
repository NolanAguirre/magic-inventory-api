-- Verify magic-inventory:appschema on pg

BEGIN;

SELECT 1/COUNT(*) FROM sys.schemas WHERE name = 'magic_inventory';

ROLLBACK;
