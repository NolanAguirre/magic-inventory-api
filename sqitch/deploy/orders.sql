-- Deploy magic-inventory:orders to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.orders(
    cards magic_inventory.magic_card[],
    store_id text,
    user_id text,
    order_id SERIAL UNIQUE, -- needs to change probably
    order_status magic_inventory.order_status,
    created_at timestamp default now()
);

COMMIT;
