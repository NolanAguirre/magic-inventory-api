-- Verify magic-inventory:admins on pg

BEGIN;


SELECT 1/ COUNT(*) FROM pg_tables WHERE schemaname = 'magic_inventory' AND tablename = 'admins';

ROLLBACK;
