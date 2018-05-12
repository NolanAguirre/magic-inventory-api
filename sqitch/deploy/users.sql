-- Deploy magic-inventory:users to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.users(
  app_user magic_inventory.user_type
);
COMMENT ON TABLE magic_inventory.users is 'Table of users and their data.';

COMMIT;
