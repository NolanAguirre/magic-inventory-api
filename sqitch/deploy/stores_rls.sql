-- Deploy magic-inventory:stores_rls to pg
-- requires: stores

BEGIN;

ALTER TABLE magic_inventory.stores ENABLE ROW LEVEL SECURITY;

CREATE POLICY inventory_managers ON magic_inventory.stores TO magic_inventory_employee, magic_inventory_store_owner
    USING (true)
    WITH CHECK(id = (SELECT store_id FROM magic_inventory.admins WHERE user_id =
    (SELECT user_id FROM magic_inventory_private.users WHERE user_id = magic_inventory.get_id())));


COMMIT;
