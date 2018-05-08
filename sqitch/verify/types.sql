-- Verify magic-inventory:types on pg

BEGIN;

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'magic_card_condition';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'magic_card';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'role';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'order_status';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'user';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card_status';

ROLLBACK;
