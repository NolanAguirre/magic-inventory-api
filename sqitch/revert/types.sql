-- Revert magic-inventory:types from pg

BEGIN;

DROP TYPE magic_inventory.card_types;

DROP TYPE magic_inventory.card_condition;

DROP TYPE magic_inventory.card;

DROP TYPE magic_inventory.user;

COMMIT;
