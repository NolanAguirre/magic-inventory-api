-- Deploy magic-inventory:order_item to pg
-- requires: users
-- requires: types
-- requires: cards
-- requires: stores
-- requires orders

BEGIN;

CREATE TABLE magic_inventory.order_items(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  order_id UUID REFERENCES magic_inventory.orders(id),
  inventory_id UUID REFERENCES magic_inventory.inventory(id),
  CONSTRAINT order_item_key UNIQUE (order_id)
);

COMMIT;
