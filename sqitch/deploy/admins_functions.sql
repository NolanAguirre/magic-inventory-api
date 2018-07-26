-- Deploy magic-inventory:admins_functions to pg
-- requires: admins

BEGIN;

CREATE FUNCTION magic_inventory.get_admin_store() returns UUID AS $$
    SELECT store_id FROM magic_inventory.admins WHERE user_id = magic_inventory.get_id();
$$ LANGUAGE SQL SECURITY DEFINER;

COMMIT;
