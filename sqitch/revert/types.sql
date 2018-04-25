-- Revert magic-inventory:types from pg

BEGIN;

DROP TYPE magic_inventory.card_type;

DROP TYPE magic_inventory.card_condition CASCADE;

DROP TYPE magic_inventory.card;

DROP TYPE magic_inventory.user;

COMMIT;
