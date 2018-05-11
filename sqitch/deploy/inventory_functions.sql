-- Deploy magic-inventory:inventory_functions to pg
-- requires: inventory

BEGIN;

CREATE FUNCTION magic_inventory.add_inventory(json[], TEXT) RETURNS VOID AS $$ -- json of store cards, and
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


CREATE FUNCTION magic_inventory.remove_inventory(json[], TEXT) RETURNS BOOLEAN AS $$
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


COMMIT;
