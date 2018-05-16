-- Deploy magic-inventory:users to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.users(
  id UUID PRIMARY KEY,
  auth0_id text,
  name citext,
  email citext
);
COMMENT ON TABLE magic_inventory.users is 'Table of users and their data.';

COMMIT;
