-- Revert magic-inventory:card_functions from pg

BEGIN;

-- DROP FUNCTION magic_inventory.create_magic_card(json);
--
-- DROP FUNCTION magic_inventory.typeahead(CITEXT);

COMMIT;
