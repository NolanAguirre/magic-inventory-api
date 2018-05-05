-- Revert magic-inventory:types from pg

BEGIN;

DROP TYPE magic_inventory.card_type CASCADE;

DROP TYPE magic_inventory.card_condition CASCADE;

DROP TYPE magic_inventory.magic_card CASCADE;

DROP TYPE magic_inventory.role CASCADE;

DROP TYPE magic_inventory.unique_name_user CASCADE;

DROP TYPE magic_inventory.card_status CASCADE;

COMMIT;
