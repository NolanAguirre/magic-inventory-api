-- Verify magic-inventory:order_functions on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_proc WHERE proname = 'place_order' and proschema = 'magic_inventory';

SELECT 1/ COUNT(*) FROM pg_proc WHERE proname = 'update_order' and proschema = 'magic_inventory';

ROLLBACK;
