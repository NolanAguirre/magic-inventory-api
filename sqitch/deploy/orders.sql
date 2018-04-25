-- Deploy magic-inventory:orders to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.orders(
    cards magic_inventory.card[],
    store_id text,
    user_id text,
    created_at timestamp default now()
)

COMMIT;
