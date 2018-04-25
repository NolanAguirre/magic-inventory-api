-- Revert magic-inventory:orders from pg

BEGIN;

DROP TABLE magic_inventory.orders;

COMMIT;
