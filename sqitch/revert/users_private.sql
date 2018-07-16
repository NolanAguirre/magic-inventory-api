-- Revert magic-inventory:users_private from pg

BEGIN;

DROP TABLE magic_inventory_private.users;

COMMIT;
