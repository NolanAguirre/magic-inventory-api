-- Revert magic-inventory:stores from pg

BEGIN;

DROP TABLE magic_inventory.stores;

COMMIT;
