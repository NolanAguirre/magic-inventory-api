-- Verify magic-inventory:types on pg

BEGIN;

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card_type_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card_condition_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'magic_card_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'inventory_card_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'role_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'order_status_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'user_type';

SELECT 1/COUNT(*) FROM pg_type WHERE typname = 'card_status_type';

ROLLBACK;
