-- Verify magic-inventory:inventory on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_tables WHERE schemaname = 'magic_inventory' AND tablename = 'inventory';

ROLLBACK;
