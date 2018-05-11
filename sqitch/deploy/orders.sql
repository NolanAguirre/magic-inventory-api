-- Deploy magic-inventory:orders to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.orders(
    cards magic_inventory.inventory_card_type[],
    store_id text,
    user_id text,
    order_status magic_inventory.order_status_type,
    created_at timestamp default now(),
    order_id SERIAL UNIQUE -- needs to change probably
);

COMMIT;
