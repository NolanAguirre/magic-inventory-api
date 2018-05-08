-- Deploy magic-inventory:card_functions to pg
-- requires: types

BEGIN;
-- used to get the complete data of a card from the given json object
CREATE FUNCTION magic_inventory.create_card(json) RETURNS magic_inventory.magic_card AS $$
  SELECT tcg_id            FROM magic_inventory WHERE card.name = $1.name AND card.card_set = $1.card_set as temp_tcg_id;
  SELECT image             FROM magic_inventory WHERE card.name = $1.name AND card.card_set = $1.card_set as temp_image;
  SELECT set_code          FROM magic_inventory WHERE card.name = $1.name AND card.card_set = $1.card_set as temp_set_code;
  SELECT set_name          FROM magic_inventory WHERE card.name = $1.name AND card.card_set = $1.card_set as temp_set_name;
  SELECT collectors_number FROM magic_inventory WHERE card.name = $1.name AND card.card_set = $1.card_set as temp_collectors_number;
  RETURN ROW($1.name, temp_tcg_id, temp_image, $1.card_set, temp_set_code, temp_set_name, temp_collectors_number, $1.condition $1.variations)::magic_inventory.card;
$$ LANGUAGE SQL;

COMMIT;
