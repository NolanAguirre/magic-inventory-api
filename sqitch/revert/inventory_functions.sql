-- Revert magic-inventory:inventory_functions from pg

BEGIN;

-- DROP FUNCTION magic_inventory.add_inventory(json[], TEXT);
--
-- DROP FUNCTION magic_inventory.remove_inventory(json[], TEXT);
--
-- DROP FUNCTION magic_inventory.add_inventory(magic_inventory.inventory_card_type[], TEXT);
--
-- DROP FUNCTION magic_inventory.add_inventory(magic_inventory.inventory_card_type, TEXT);

COMMIT;
