-- Deploy magic-inventory:users to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.users(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  first_name CITEXT,
  last_name CITEXT,
  user_name CITEXT UNIQUE
);
COMMENT ON TABLE magic_inventory.users is 'Table of users and their data.';

COMMIT;
