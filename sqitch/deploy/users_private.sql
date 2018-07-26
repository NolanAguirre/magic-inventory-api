-- Deploy magic-inventory:users_private to pg
-- requires: users

BEGIN;

CREATE TABLE magic_inventory_private.users(
  user_id       UUID PRIMARY KEY REFERENCES magic_inventory.users(id) ON DELETE CASCADE,
  email         CITEXT NOT NULL UNIQUE CHECK(email ~* '^.+@.+\..+$'),
  password_hash TEXT NOT NULL,
  role          magic_inventory.role_type
);

COMMIT;
