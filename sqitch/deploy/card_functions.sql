-- Deploy magic-inventory:card_functions to pg
-- requires: types

BEGIN;
-- used to get the complete data of a card from the given json object from an inventory
CREATE FUNCTION magic_inventory.create_magic_card(json) RETURNS magic_inventory.magic_card_type AS $$
  DECLARE
  tcg_id INTEGER;
  image TEXT;
  set_code CITEXT;
  set_name CITEXT;
  collectors_number INTEGER;
  BEGIN
    tcg_id := (SELECT tcg_id FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).card_set = $1.card_set);
    image := (SELECT image FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).card_set = $1.card_set);
    set_code := (SELECT set_code FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).card_set = $1.card_set);
    set_name := (SELECT set_name FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).card_set = $1.card_set);
    collectors_number := (SELECT collectors_number FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).card_set = $1.card_set);
    RETURN ROW($1.name, tcg_id, image, $1.card_set, set_code, set_name, collectors_number, $1.condition, ,$1.variations)::magic_inventory.magic_card_type;
  END
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.to_inventory_card(magic_inventory.magic_card_type, INTEGER) RETUSN magic_inventory.inventory_card_type AS $$
  RETURN ROW($1.name, $1.tcg_id, $1.image,$1.card_set, $1.set_code, $1.set_name, $1.collectors_number, $1.condition, $1.variations, $2)::magic_inventory.inventory_card_type;
$$ LANGUAGE PLPGSQL;

COMMIT;
