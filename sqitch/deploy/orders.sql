-- Deploy magic-inventory:orders to pg
-- requires: appschema
-- requires: types
-- requires: cards
-- requires: stores
-- requires: users

BEGIN;

CREATE TABLE magic_inventory.orders(
  card_id UUID REFERENCES magic_inventory.cards(id),
  store_id UUID REFERENCES magic_inventory.stores(id),
  user_id UUID REFERENCES magic_inventory.users(id),
  order_status magic_inventory.order_status_type,
  condition magic_inventory.card_condition_type,
  created_at timestamp default now(),
  CONSTRAINT order_item_key PRIMARY KEY (card_id, store_id, user_id)
);

COMMENT ON TABLE magic_inventory.orders is 'All the orders that have been placed to stores.';

COMMIT;
