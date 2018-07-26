-- Verify magic-inventory:order_item on pg

BEGIN;

SELECT 1/ COUNT(*) FROM pg_tables WHERE schemaname = 'magic_inventory' AND tablename = 'order_items';

ROLLBACK;
