-- Revert magic-inventory:users from pg

BEGIN;

DROP TABLE magic_inventory.users;

COMMIT;
