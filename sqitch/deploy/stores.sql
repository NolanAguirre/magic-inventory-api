-- Deploy magic-inventory:stores to pg
-- requires: appschema

BEGIN;

CREATE TABLE magic_inventory.stores(
  id UUID PRIMARY KEY,
  store_name citext,
  server_settings json,
  client_settings json,
);

COMMENT ON TABLE magic_inventory.stores is 'Stores and their data, not inventory.';

COMMIT;
