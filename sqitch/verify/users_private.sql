-- Verify magic-inventory:users_private on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_tables WHERE schemaname = 'magic_inventory_private' AND tablename = 'users';

ROLLBACK;
