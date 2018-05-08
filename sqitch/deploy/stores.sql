-- Deploy magic-inventory:stores to pg
-- requires: appschema

BEGIN;

CREATE TABLE magic_inventory.stores(
  store_name citext,
  store_id text,
  server_settings json,
  client_settings json,
  admins text[]
);

COMMIT;
