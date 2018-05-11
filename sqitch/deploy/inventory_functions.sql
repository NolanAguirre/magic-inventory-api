-- Deploy magic-inventory:inventory_functions to pg
-- requires: inventory

BEGIN;

CREATE FUNCTION magic_inventory.add_inventory(json[], TEXT) RETURNS VOID AS $$ -- json of store cards, and
  DECLARE
    temp_card json;
  BEGIN
    FOR temp_card IN SELECT * FROM json_array_elements($1)
    LOOP
      IF(SELECT EXISTS(SELECT 1 FROM magic_inventory.inventory WHERE store_id = $2 AND (card).name = temp_card.name AND (card).set_name = temp_card.name AND (card).condition = temp_card.condition)) THEN
        UPDATE magic_inventory.inventory SET quantity = quantity + temp_card.quantity WHERE store_id = $2 AND (card).name = temp_card.name AND (card).set_name = temp_card.name AND (card).condition = temp_card.condition;
      ELSE
        INSERT INTO magic_inventory.inventory VALUES (magic_inventory.create_magic_card(temp_card), $2);
      END IF;
    END LOOP;
  END
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.remove_inventory(json[], TEXT) RETURNS VOID AS $$
  DECLARE
  temp_card json;
  BEGIN
    FOR temp_card in SELECT * FROM json_array_elements($1)
    LOOP

    END LOOP;
  END
$$ LANGUAGE PLPGSQL;


COMMIT;
