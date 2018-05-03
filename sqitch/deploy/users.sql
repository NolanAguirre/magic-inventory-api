-- Deploy magic-inventory:users to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.users(
  app_user magic_inventory.unique_name_user
);

COMMIT;
