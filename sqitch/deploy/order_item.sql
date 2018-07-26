-- Deploy magic-inventory:order_item to pg
-- requires: orders
-- requires: inventory

BEGIN;

CREATE TABLE magic_inventory.order_items(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  order_id UUID REFERENCES magic_inventory.orders(id),
  inventory_id UUID REFERENCES magic_inventory.inventory(id)
);

COMMIT;
