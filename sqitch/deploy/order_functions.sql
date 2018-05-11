-- Deploy magic-inventory:order_functions to pg
-- requires: orders
-- requires: stores
-- requires: users

BEGIN;

CREATE FUNCTION magic_inventory.place_order(json[], TEXT, TEXT) RETURNS VOID AS $$
  DECLARE
    card_array magic_inventory.magic_card_type[];
    placeholder magic_inventory.magic_card_type[];
  BEGIN
    FOR temp_card IN SELECT * FROM json_array_elements($1)
    LOOP
      placeholder := magic_inventory.create_magic_card(temp_card);
      magic_inventory.update_card_status(placeholder, 'ordered');
      array_append(card_array, magic_inventory.create_magic_card(temp_card));
    END LOOP;
  INSERT INTO magic_inventory.orders(card_array, $2, $3, 'sent');
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.update_order(INTEGER, magic_inventory.order_status_type) RETURNS VOID AS $$
  DECLARE
    temp_card magic_inventory.magic_card_type;
    temp_card_array magic_inventory.magic_card_type[];
  BEGIN
    temp_card_array := SELECT 1 FROM magic_inventory.inventory WHERE order_id = $1;
    FOREACH temp_card IN ARRAY temp_card_array
    LOOP
      UPDATE magic_inventory.orders SET order_status TO $2;
      IF ($2 = 'complete') THEN
        UPDATE magic_inventory.cards SET (card).card_status TO 'sold' WHERE card = temp_card;
      ELSE IF ($2 = 'cancled') THEN
        UPDATE magic_inventory.cards SET (card).card_status TO 'available' WHERE card = temp_card;
      END IF;
    END LOOP;
  END;
$$ LANGUAGE PLPGSQL;

COMMIT;
