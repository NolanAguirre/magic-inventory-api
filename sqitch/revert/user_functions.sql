-- Revert magic-inventory:user_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.add_user(citext, text, citext);

DROP FUNCTION magic_inventory.remove_user(text);

COMMIT;
