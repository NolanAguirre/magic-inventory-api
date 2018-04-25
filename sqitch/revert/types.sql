-- Revert magic-inventory:types from pg

BEGIN;

DROP TYPE magic_inventory.card_type CASCADE;

DROP TYPE magic_inventory.card_condition CASCADE;

DROP TYPE magic_inventory.card CASCADE;

DROP TYPE magic_inventory.user CASCADE;

DROP TYPE magic_inventory.card_status CASCADE;

COMMIT;
