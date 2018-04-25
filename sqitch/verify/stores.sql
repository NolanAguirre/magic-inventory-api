-- Verify magic-inventory:stores on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_tables WHERE schemaname = 'magic_inventory' AND tablename = 'stores';

ROLLBACK;
