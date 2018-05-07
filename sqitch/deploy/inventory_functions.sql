-- Deploy magic-inventory:inventory_functions to pg
-- requires: inventory

BEGIN;

CREATE FUNCTION magic_inventory.add_inventory(json[], TEXT) RETURNS VOID AS $$ -- json of store cards, and
  BEGIN
    FOR x IN SELECT * FROM json_array_elements($1)
    LOOP
      IF(SELECT EXISTS(SELECT 1 FROM magic_inventory.inventory WHERE store_id = $2 AND card.name = x.name AND card.set_name = x.name AND card.condition = x.condition)) THEN
        UPDATE magic_inventory.inventory SET quantity = quantity + x.quantity WHERE store_id = $2 AND card.name = x.name AND card.set_name = x.name AND card.condition = x.condition)
      ELSE
        INSERT INTO magic_inventory.inventory VALUES (magic_inventory.create_card(x), $2);
      END IF;
    END LOOP;
  END

$$ LANGUAGE PLPGSQL;


COMMIT;
