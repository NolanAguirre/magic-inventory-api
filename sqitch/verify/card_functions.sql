-- Verify magic-inventory:card_functions on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_proc WHERE proname = 'create_card' and proschema = 'magic_inventory';

ROLLBACK;
