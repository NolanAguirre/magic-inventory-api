-- Revert magic-inventory:views from pg

BEGIN;

DROP VIEW magic_inventory.card_name;

DROP VIEW magic_inventory.card_set;

COMMIT;
