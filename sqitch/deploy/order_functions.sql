-- Deploy magic-inventory:order_functions to pg
-- requires: orders
-- requires: stores
-- requires: users

BEGIN;
-- this shit needs to track cards sold in orders, but not in inventory, inventory will be added and removed with orders
--orders need to accept the list, the to and the from
--from that it needs to remove the cards from inventory, and create an order
--only available cards show in inventory, cards in other statuses are kept in the order history.
CREATE FUNCTION magic_inventory.place_order(json[], TEXT, TEXT) RETURNS VOID AS $$ -- cards, store id, user who ordered
  DECLARE
    card_array magic_inventory.magic_card_type[];
    temp_card magic_inventory.magic_card_type;
    json_card json;
  BEGIN
    SELECT magic_inventory.remove_inventory($1, $2);
    FOR json_card IN SELECT * FROM json_array_elements($1)
    LOOP
      temp_card := magic_inventory.create_magic_card(json_card);
      card_array := array_append(card_array, temp_card);
    END LOOP;
  INSERT INTO magic_inventory.orders (cards, store_id, user_id, order_status) VALUES (card_array, $2, $3, 'sent');
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.update_order(INTEGER, magic_inventory.order_status_type) RETURNS VOID AS $$
  DECLARE
    temp_card magic_inventory.magic_card_type;
    temp_card_array magic_inventory.magic_card_type[];
  BEGIN

    temp_card_array := (SELECT 1 FROM magic_inventory.inventory WHERE order_id = $1);
    FOREACH temp_card IN ARRAY temp_card_array
    LOOP
      UPDATE magic_inventory.orders SET order_status = 'sold' WHERE order_id = $1;
      IF ($2 = 'cancled') THEN
        UPDATE magic_inventory.inventory SET card.card_status = 'available' WHERE card = temp_card;
      END IF;
    END LOOP;
  END;
$$ LANGUAGE PLPGSQL;

COMMIT;
