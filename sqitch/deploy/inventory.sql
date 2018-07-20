-- Deploy magic-inventory:inventory to pg
-- requires: appschema
-- requires: types
-- requires: cards
-- requires: stores

BEGIN;

CREATE TABLE magic_inventory.inventory(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  card_id UUID REFERENCES magic_inventory.cards(id),
  store_id UUID REFERENCES magic_inventory.stores(id),
  condition magic_inventory.card_condition_type,
  status magic_inventory.card_status_type,
  price FLOAT
);

ALTER TABLE magic_inventory.inventory ENABLE ROW LEVEL SECURITY;

CREATE POLICY account_managers ON magic_inventory.inventory TO magic_inventory_employee USING ( = current_user);

COMMENT ON TABLE magic_inventory.inventory is 'All the magic cards in stores inventory.';

COMMIT;
