-- Deploy magic-inventory:order_functions to pg
-- requires: orders
-- requires: stores
-- requires: users
-- requires types

BEGIN;
CREATE FUNCTION magic_inventory.place_order(agrs_card_ids UUID[],args_store_id UUID, args_use_id UUID) RETURNS VOID AS $$ -- cards, store id, user who ordered
  DECLARE
    inventory_card_id UUID;
    card_condition magic_inventory.card_condition_type;
    temp UUID;
  BEGIN
    temp := uuid_generate_v4();
    FOREACH inventory_card_id IN ARRAY $1
    LOOP
      card_condition := (SELECT condition FROM magic_inventory.inventory WHERE id = inventory_card_id);
      INSERT INTO magic_inventory.orders (order_number, card_id, store_id, user_id, order_status, condition) VALUES (temp, inventory_card_id, $2, $3, "sent", card_condition);
      DELETE FROM magic_inventory.inventory WHERE id = $1; -- could just be a function call
    END LOOP;
  END;
$$ LANGUAGE PLPGSQL;

-- CREATE FUNCTION magic_inventory.update_order_status(args_order_id INTEGER, args_order_status magic_inventory.order_status_type) RETURNS VOID AS $$
--   BEGIN
--     UPDATE magic_inventory.orders SET order_status = $2 WHERE order_id = $1;
--     IF ($2 = 'cancled') THEN
--       SELECT magic_inventory.add_inventory((SELECT cards FROM magic_inventory.orders WHERE order_id = $1), (SELECT store_id  FROM magic_inventory.orders WHERE order_id = $1));
--     END IF;
--   END;
-- $$ LANGUAGE PLPGSQL;
--
-- COMMENT ON FUNCTION magic_inventory.place_order(json[], TEXT, TEXT) is 'Accepts json array of cards and creates an order, and removes the cards from inventory';
-- COMMENT ON FUNCTION magic_inventory.update_order_status(INTEGER, magic_inventory.order_status_type) is 'Handles the progression of an order, adds cards back to invntory if the order is cancled';
--

COMMIT;
