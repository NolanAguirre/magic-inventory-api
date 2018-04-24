-- Revert magic-inventory:types from pg

BEGIN;

DROP TYPE card_types;

DROP TYPE card_condition;

DROP TYPE card;

DROP TYPE user;

COMMIT;
