-- Deploy magic-inventory:card_functions to pg
-- requires: types

BEGIN;
-- used to get the complete data of a card from the given json object from an inventory
CREATE FUNCTION magic_inventory.create_magic_card(arg_card_data json) RETURNS magic_inventory.magic_card_type AS $$
  DECLARE
  tcg_id INTEGER;
  set_name CITEXT;
  collectors_number INTEGER;
  BEGIN
    tcg_id := (SELECT tcg_id FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).set_name = $1.card_set);
    set_name := (SELECT set_name FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).set_name = $1.card_set);
    collectors_number := (SELECT collectors_number FROM magic_inventory.inventory WHERE (card).name = $1.name AND (card).set_name = $1.card_set);
    RETURN ROW($1.name, tcg_id, $1.set_code, set_name, collectors_number, $1.condition, $1.variations)::magic_inventory.magic_card_type;
  END
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.to_inventory_card(arg_magic_card magic_inventory.magic_card_type, arg_quantity INTEGER) RETURNS magic_inventory.inventory_card_type AS $$
  BEGIN
    RETURN (ROW($1.name, $1.tcg_id, $1.set_code, $1.set_name, $1.collectors_number, $1.condition, $1.variations, $2)::magic_inventory.inventory_card_type);
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.typeahead(arg_card_name CITEXT) RETURNS SETOF magic_inventory.magic_card_type AS $$
  BEGIN
    RETURN QUERY SELECT 10 FROM magic_inventory.cards WHERE card.name = $1 + '%';
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.query_card(arg_card_data json) RETURNS SETOF magic_inventory.magic_card_type AS $$
  BEGIN
    IF (SELECT $1->'card_name' is not null) THEN
      RETURN QUERY SELECT * FROM magic_inventory.card WHERE card.name = $1.name;
    ELSE
      RETURN QUERY SELECT * FROM magic_inventory.card WHERE card.set_code = $1.set_code AND card.set_name = $1.set_name;
      END IF;
  END;
$$ LANGUAGE PLPGSQL;

COMMENT ON FUNCTION magic_inventory.create_magic_card(json) is 'Internal use only.';
COMMENT ON FUNCTION magic_inventory.to_inventory_card(magic_inventory.magic_card_type, INTEGER) is 'Internal use only.';
COMMENT ON FUNCTION magic_inventory.typeahead(CITEXT) is 'Typeahead query endpoint.';



COMMIT;
