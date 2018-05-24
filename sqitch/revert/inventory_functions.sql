-- Revert magic-inventory:inventory_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.add_inventory(json[], UUID);

--DROP FUNCTION magic_inventory.add_inventory(UUID);

DROP FUNCTION magic_inventory.remove_inventory(UUID[]);

--DROP FUNCTION magic_inventory.remove_inventory(UUID);


COMMIT;
