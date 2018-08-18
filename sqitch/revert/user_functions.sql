-- Revert magic-inventory:user_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.register_user(CITEXT, CITEXT, CITEXT, TEXT);

DROP FUNCTION magic_inventory.authenticate(CITEXT, TEXT);

DROP FUNCTION magic_inventory.update_role(UUID, magic_inventory.role_type);

DROP FUNCTION magic_inventory.get_user_data();

DROP FUNCTION magic_inventory.get_id();

DROP FUNCTION magic_inventory.get_role();

COMMIT;
