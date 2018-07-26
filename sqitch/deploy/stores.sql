-- Deploy magic-inventory:stores to pg
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.stores(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email CITEXT UNIQUE CHECK(email ~* '^.+@.+\..+$'),
  phone_number varchar(10),
  name citext,
  city CITEXT,
  zip_code CITEXT,
  state magic_inventory.state_type,
  server_settings json,
  client_settings json
);

COMMENT ON TABLE magic_inventory.stores is 'Stores and their data, not inventory.';

COMMIT;
