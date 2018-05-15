-- Revert magic-inventory:store_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.create_store(CITEXT);

DROP FUNCTION magic_inventory.update_store_settings(json);

DROP FUNCTION magic_inventory.delete_store(TEXT);

COMMIT;
