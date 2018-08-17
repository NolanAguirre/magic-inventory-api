-- Deploy magic-inventory:order_items_rls to pg
-- requires: order_item
-- requires: user_functions

BEGIN;

-- ALTER TABLE magic_inventory.order_items ENABLE ROW LEVEL SECURITY;
--
-- CREATE POLICY user_order_item_view ON magic_inventory.order_items FOR SELECT TO magic_inventory_user
-- USING ((SELECT user_id FROM magic_inventory.orders WHERE id = order_id) = magic_inventory.get_id());
--
-- CREATE POLICY user_order_item_insert ON magic_inventory.order_items FOR INSERT TO magic_inventory_user
-- WITH CHECK((SELECT user_id FROM magic_inventory.orders WHERE id = order_id) = magic_inventory.get_id());

COMMIT;
