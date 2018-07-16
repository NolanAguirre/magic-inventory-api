-- Deploy magic-inventory:admins to pg
-- requires: users
-- requires: stores

BEGIN;

CREATE TABLE magic_inventory.admins(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES magic_inventory.users(id),
  store_id UUID REFERENCES magic_inventory.stores(id),
  CONSTRAINT admins_key UNIQUE (user_id, store_id)
);

COMMIT;
