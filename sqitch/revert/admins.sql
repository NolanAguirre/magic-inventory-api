-- Revert magic-inventory:admins from pg

BEGIN;

DROP TABLE magic_inventory.admins;

COMMIT;
