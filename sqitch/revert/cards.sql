-- Revert magic-inventory:cards from pg

BEGIN;

DROP TABLE magic_inventory.cards;

COMMIT;
