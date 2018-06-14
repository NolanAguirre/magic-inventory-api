-- Deploy magic-inventory:views to pg
-- requires: cards

BEGIN;

CREATE VIEW magic_inventory.card_name AS SELECT DISTINCT name FROM magic_inventory.cards;

COMMIT;
