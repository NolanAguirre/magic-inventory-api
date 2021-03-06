-- Deploy magic-inventory:orders to pg
-- requires: cards
-- requires: stores
-- requires: users

BEGIN;

CREATE TABLE magic_inventory.orders(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  store_id UUID REFERENCES magic_inventory.stores(id),
  user_id UUID REFERENCES magic_inventory.users(id),
  order_status magic_inventory.order_status_type,
  created_at timestamp default now(),
  price FLOAT
);

COMMENT ON TABLE magic_inventory.orders is 'All the orders that have been placed to stores.';

COMMIT;
