-- Revert magic-inventory:inventory from pg

BEGIN;

DROP TABLE magic_inventory.inventory;

COMMIT;
