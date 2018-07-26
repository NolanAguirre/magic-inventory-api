-- Deploy magic-inventory:inventory_rls to pg
-- requires: inventory
-- requires: admin_functions

BEGIN;

ALTER TABLE magic_inventory.inventory ENABLE ROW LEVEL SECURITY;

CREATE POLICY insert_if_admin ON magic_inventory.inventory FOR INSERT TO magic_inventory_employee, magic_inventory_store_owner
WITH CHECK(store_id = magic_inventory.get_admin_store());

COMMIT;
