-- Revert magic-inventory:admin_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.get_admin_store();

COMMIT;
