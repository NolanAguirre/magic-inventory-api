-- Verify magic-inventory:card_functions on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_proc WHERE proname = 'create_magic_card' and proschema = 'magic_inventory';

SELECT 1/ COUNT(*) FROM pg_proc WHERE proname = 'to_inventory_card' and schema = 'magic_inventory';

ROLLBACK;
