-- Revert magic-inventory:card_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.create_magic_card(json);

DROP FUNCTION magic_inventory.to_inventory_card(magic_inventory.magic_card_type, INTEGER);

COMMIT;
