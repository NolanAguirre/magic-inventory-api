-- Deploy magic-inventory:users to pg
-- requires: appschema

BEGIN;

CREATE TABLE magic_inventory.users(
  user magic_inventory.user
)

COMMIT;
