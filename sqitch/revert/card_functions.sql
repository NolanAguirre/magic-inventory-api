-- Revert magic-inventory:card_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.typeahead(CITEXT);

COMMIT;
