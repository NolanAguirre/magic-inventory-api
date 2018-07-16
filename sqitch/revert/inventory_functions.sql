-- Revert magic-inventory:inventory_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.inventory_typeahead(arg_one CITEXT , arg_two UUID);

DROP FUNCTION magic_inventory.inventory_by_card_name_and_store_id(arg_one CITEXT, arg_two UUID);
COMMIT;
