-- Revert magic-inventory:order_item from pg

BEGIN;

DROP TABLE magic_inventory.order_items;

COMMIT;
