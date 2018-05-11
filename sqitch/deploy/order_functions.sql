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
    card_array magic_inventory.inventory_card_type[];
    temp_card magic_inventory.inventory_card_type;
    json_card json;
  BEGIN
    SELECT magic_inventory.remove_inventory($1, $2);
    FOR json_card IN SELECT * FROM json_array_elements($1)
    LOOP
      temp_card := magic_inventory.to_inventory_card(magic_inventory.create_magic_card(json_card));
      card_array := array_append(card_array, temp_card);
    END LOOP;
  INSERT INTO magic_inventory.orders (cards, store_id, user_id, order_status) VALUES (card_array, $2, $3, 'sent');
  END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.update_order(INTEGER, magic_inventory.order_status_type) RETURNS VOID AS $$
  BEGIN
    UPDATE magic_inventory.orders SET order_status = 'sold' WHERE order_id = $1;
    IF ($2 = 'cancled') THEN
      magic_inventory.add_inventory((SELECT cards FROM magic_inventory.orders WHERE order_id = $1), (SELECT store_id  FROM magic_inventory.orders WHERE order_id = $1));
    END IF;
  END;
$$ LANGUAGE PLPGSQL;

COMMIT;
