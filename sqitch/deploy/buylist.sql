-- Deploy magic-inventory:buylist to pg
-- requires: cards
-- requires: stores

BEGIN;

CREATE TABLE magic_inventory.buylist(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    card_id UUID REFERENCES magic_inventory.cards(id),
    store_id UUID REFERENCES magic_inventory.stores(id),
    condition magic_inventory.card_condition_type,
    amount INTEGER,
    price FLOAT
);

COMMIT;
