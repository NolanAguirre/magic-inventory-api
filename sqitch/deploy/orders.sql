-- Deploy magic-inventory:orders to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.orders(
    cards magic_inventory.magic_card[],
    store_id text,
    user_id text,
    order_id SERIAL UNIQUE,
    created_at timestamp default now()
);

COMMIT;
