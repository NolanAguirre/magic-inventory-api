-- Revert magic-inventory:buylist from pg

BEGIN;

DROP TABLE magic_inventory.buylist;

COMMIT;
