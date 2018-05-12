-- Deploy magic-inventory:inventory_functions to pg
-- requires: inventory

BEGIN;

CREATE FUNCTION magic_inventory.add_inventory(arg_cards_data json[], arg_store_id TEXT) RETURNS VOID AS $$ -- json of store cards, and
  DECLARE
    json_card json;
  BEGIN
    FOR json_card IN SELECT * FROM json_array_elements($1)
    LOOP
      IF(SELECT EXISTS(SELECT 1 FROM magic_inventory.inventory WHERE store_id = $2 AND (card).name = json_card.name AND (card).set_name = json_card.name AND (card).condition = json_card.condition)) THEN
        UPDATE magic_inventory.inventory SET card.quantity = (card).quantity + json_card.quantity WHERE store_id = $2 AND (card).name = json_card.name AND (card).set_name = json_card.name AND (card).condition = json_card.condition;
      ELSE
        INSERT INTO magic_inventory.inventory VALUES (magic_inventory.to_inventory_card(magic_inventory.create_magic_card(json_card),json_card.quantity), $2, 'available');
      END IF;
    END LOOP;
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.add_inventory(arg_inventory_cards magic_inventory.inventory_card_type[], arg_store_id TEXT) RETURNS VOID AS $$
  DECLARE
    temp_card magic_inventory.inventory_card_type;
  BEGIN
    FOREACH temp_card IN ARRAY $1
    LOOP
      SELECT magic_inventory.add_inventory(temp_card, $2);
    END LOOP;
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.add_inventory(arg_inventory_card magic_inventory.inventory_card_type,arg_store_id TEXT) RETURNS VOID AS $$
  BEGIN
    IF(SELECT EXISTS(SELECT 1 FROM magic_inventory.inventory WHERE store_id = $2 AND (card).name = $1.name AND (card).set_name = $1.name AND (card).condition = $1.condition)) THEN
      UPDATE magic_inventory.inventory SET card.quantity = (card).quantity + $1.quantity WHERE store_id = $2 AND (card).name = $1.name AND (card).set_name = $1.name AND (card).condition = $1.condition;
    ELSE
      INSERT INTO magic_inventory.inventory (card, store_id, availability) VALUES ($1, $2, 'available');
    END IF;
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.remove_inventory(arg_cards_data json[], arg_store_id TEXT) RETURNS BOOLEAN AS $$
  DECLARE
  json_card json;
  contains_all_cards BOOLEAN;
  BEGIN
    contains_all_cards := true;
    FOR json_card in SELECT * FROM json_array_elements($1)
    LOOP
      IF(SELECT EXISTS(SELECT 1 FROM magic_inventory.inventory WHERE store_id = $2 AND (card).name = temp_card.name AND (card).set_name = temp_card.name AND (card).condition = temp_card.condition)) THEN
        --do nothing if its there
      ELSE
        contains_all_cards := false;
      END IF;
    END LOOP;
    IF(contains_all_cards) THEN
    FOR json_card IN SELECT * FROM json_array_elements($1)
      LOOP
        IF(SELECT EXISTS(SELECT 1 FROM magic_inventory.inventory WHERE store_id = $2 AND (card).name = json_card.name AND (card).set_name = json_card.name AND (card).condition = json_card.condition AND (card).quantity > json_card.quantity)) THEN
          UPDATE magic_inventory.inventory SET card.quantity = (card).quantity - json_card.quantity WHERE store_id = $2 AND (card).name = json_card.name AND (card).set_name = json_card.name AND (card).condition = json_card.condition;
        ELSE
          DELETE FROM magic_inventory.inventory WHERE store_id = $2 AND (card).name = json_card.name AND (card).set_name = json_card.name AND (card).condition = json_card.condition;
        END IF;
      END LOOP;
      RETURN true;
    ELSE
      RETURN false;
    END IF;
  END;
$$ LANGUAGE PLPGSQL;

COMMENT ON FUNCTION magic_inventory.add_inventory(json[], TEXT) is 'Accepts json array of cards and adds them to the stores inventory';
COMMENT ON FUNCTION magic_inventory.add_inventory(magic_inventory.inventory_card_type[], TEXT) is 'Internal use only.';
COMMENT ON FUNCTION magic_inventory.add_inventory(magic_inventory.inventory_card_type, TEXT) is 'Internal use only.';
COMMENT ON FUNCTION magic_inventory.remove_inventory(json[], TEXT) is 'Accepts json array of cards and removes them to the stores inventory';

COMMIT;
