-- Deploy magic-inventory:inventory to pg
-- requires: appschema
-- requires: types

BEGIN;

CREATE TABLE magic_inventory.inventory(
  card_id REFERENCES magic_inventory.cards(id),
  store_id REFERENCES magic_inventory.stores(id),
  condition magic_inventory.card_condition_type,
  CONSTRAINT inventory_item_key  PRIMARY KEY (card_id, store_id)
);
COMMENT ON TABLE magic_inventory.inventory is 'All the magic cards in stores inventory.';

COMMIT;
