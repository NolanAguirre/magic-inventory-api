-- Verify magic-inventory:roles on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_roles WHERE rolname='magic_inventory_roles';

SELECT 1/ COUNT(*) FROM pg_roles WHERE rolname='magic_inventory_user';

SELECT 1/ COUNT(*) FROM pg_roles WHERE rolname='magic_inventory_anonymous';

SELECT 1/ COUNT(*) FROM pg_roles WHERE rolname='magic_inventory_employee';

SELECT 1/ COUNT(*) FROM pg_roles WHERE rolname='magic_inventory_store_owner';

ROLLBACK;
