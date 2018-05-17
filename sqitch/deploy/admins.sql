-- Deploy magic-inventory:admins to pg
-- requires: users
-- requires: stores

BEGIN;

CREATE TABLE magic_inventory.admins(
  user_id UUID REFERENCES magic_inventory.users(id),
  store_id UUID REFERENCES magic_inventory.store(id),
  CONSTRAINT admins_key PRIMARY KEY(user_id, store_id)
)

COMMIT;
