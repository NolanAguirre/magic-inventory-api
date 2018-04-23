-- Verify magic-inventory:types on pg

BEGIN;

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card_condition';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card';

ROLLBACK;
