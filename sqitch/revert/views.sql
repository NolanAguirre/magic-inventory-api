-- Revert magic-inventory:views from pg

BEGIN;

DROP VIEW magic_inventory.card_name;

DROP VIEW magic_inventory.card_set;

DROP VIEW magic_inventory.inventory_card_name;

DROP VIEW magic_inventory.inventory_card_set;

COMMIT;
