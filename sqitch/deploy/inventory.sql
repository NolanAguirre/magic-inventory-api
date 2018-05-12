-- Deploy magic-inventory:inventory to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.inventory(
    card magic_inventory.inventory_card_type[],
    store_id text,
    availability magic_inventory.card_status_type
);
COMMENT ON TABLE magic_inventory.inventory is 'All the magic cards in stores inventory.';

COMMIT;
