-- Revert magic-inventory:inventory_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.add_inventory(json[], TEXT);

DROP FUNCTION magic_inventory.remove_inventory(json[], TEXT);

COMMIT;
