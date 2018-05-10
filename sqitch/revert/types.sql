-- Revert magic-inventory:types from pg

BEGIN;

DROP TYPE magic_inventory.card_type_type CASCADE;

DROP TYPE magic_inventory.card_condition_type CASCADE;

DROP TYPE magic_inventory.magic_card_type CASCADE;

DROP TYPE magic_inventory.role_type CASCADE;

DROP TYPE magic_inventory.order_status_type CASCADE;

DROP TYPE magic_inventory.user_type CASCADE;

DROP TYPE magic_inventory.card_status_type CASCADE;

COMMIT;
