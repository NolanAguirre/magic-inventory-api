-- Deploy magic-inventory:admins_rls to pg
-- requires: admin_functions

BEGIN;

ALTER TABLE magic_inventory.admins ENABLE ROW LEVEL SECURITY;

CREATE POLICY promote_if_owner ON magic_inventory.admins FOR INSERT
TO magic_inventory_store_owner
WITH CHECK(store_id = magic_inventory.get_admin_store());

CREATE POLICY demote_if_owner ON magic_inventory.admins FOR DELETE
TO magic_inventory_store_owner
USING(store_id = magic_inventory.get_admin_store());

COMMIT;
