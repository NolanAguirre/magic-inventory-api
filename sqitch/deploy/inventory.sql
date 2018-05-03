-- Deploy magic-inventory:inventory to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.inventory(
    card magic_inventory.magic_card,
    quantity integer,
    store_id text,
    availability magic_inventory.card_status
);

COMMIT;
