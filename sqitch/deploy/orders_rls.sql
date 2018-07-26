-- Deploy magic-inventory:orders_rls to pg
-- requires: orders

BEGIN;

ALTER TABLE magic_inventory.orders ENABLE ROW LEVEL SECURITY;

CREATE POLICY view_if_user ON magic_inventory.orders FOR SELECT TO magic_inventory_user
USING (user_id = magic_inventory.get_id());

CREATE POLICY update_if_user ON magic_inventory.orders FOR UPDATE TO magic_inventory_user
USING(user_id = magic_inventory.get_id() AND order_status != 'complete')
WITH CHECK(order_status = 'cancled' );

CREATE POLICY insert_if_user ON magic_inventory.orders FOR INSERT TO magic_inventory_user
WITH CHECK(user_id = magic_inventory.get_id());

CREATE POLICY view_if_store ON magic_inventory.orders FOR SELECT TO magic_inventory_employee, magic_inventory_store_owner
USING(store_id = magic_inventory.get_admin_store());

-- CREATE POLICY update_if_store ON magic_inventory.orders FOR UPDATE TO magic_inventory_employee, magic_inventory_store_owner
-- USING(store_id = magic_inventory.get_admin_store() AND order_status != 'cancled' )
-- WITH CHECK();

COMMIT;
