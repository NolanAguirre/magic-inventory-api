-- Deploy magic-inventory:cards to pg
-- requires: appschema
-- requires: card_type

BEGIN;

CREATE TABLE magic_inventory.cards(
    card magic_inventory.magic_card_type
);

COMMIT;
