-- Deploy magic-inventory:buylist_rls to pg
-- requires: buylist
-- requires: admin_functions

BEGIN;

ALTER TABLE magic_inventory.buylist ENABLE ROW LEVEL SECURITY;

CREATE POLICY insert_if_admin ON magic_inventory.buylist FOR INSERT
TO magic_inventory_employee, magic_inventory_store_owner
WITH CHECK(store_id = magic_inventory.get_admin_store());

CREATE POLICY update_if_admin ON magic_inventory.buylist FOR UPDATE
TO magic_inventory_employee, magic_inventory_store_owner
USING(store_id = magic_inventory.get_admin_store())
WITH CHECK(store_id = magic_inventory.get_admin_store());


COMMIT;
