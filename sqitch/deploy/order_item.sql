-- Deploy magic-inventory:order_item to pg
-- requires: users
-- requires: types
-- requires: cards
-- requires: stores
-- requires orders

BEGIN;

CREATE TABLE magic_inventory.order_items(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  order_number UUID REFERENCES magic_inventory.orders(id),
  card_id UUID REFERENCES magic_inventory.cards(id),
  condition magic_inventory.card_condition_type,
  price FLOAT,
  CONSTRAINT order_item_key UNIQUE (order_number)
);

COMMIT;
