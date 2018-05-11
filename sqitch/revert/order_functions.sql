-- Revert magic-inventory:order_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.place_order(json[], TEXT, TEXT);

DROP FUNCTION magic_inventory.place_order(INTEGER, magic_inventory.order_status_type);

COMMIT;
