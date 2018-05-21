-- Deploy magic-inventory:cards to pg
-- requires: appschema
-- requires: card_type

BEGIN;

CREATE TABLE magic_inventory.cards(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name citext,
  tcg_id integer,
  multiverse_id integer,
  set_code citext,
  set_name citext,
  collectors_number integer,
  variations citext[]
);

COMMENT ON TABLE magic_inventory.cards is 'All the magic cards, and their data.';

COMMIT;
