-- Deploy magic-inventory:order_functions to pg
-- requires: orders
-- requires: stores
-- requires: users

BEGIN;
-- CREATE FUNCTION magic_inventory.place_order(agrs_card_data json[],args_store_id TEXT, args_use_id TEXT) RETURNS VOID AS $$ -- cards, store id, user who ordered
--   DECLARE
--     card_array magic_inventory.inventory_card_type[];
--     temp_card magic_inventory.inventory_card_type;
--     json_card json;
--   BEGIN
--     SELECT magic_inventory.remove_inventory($1, $2);
--     FOR json_card IN SELECT * FROM json_array_elements($1)
--     LOOP
--       temp_card := magic_inventory.to_inventory_card(magic_inventory.create_magic_card(json_card));
--       card_array := array_append(card_array, temp_card);
--     END LOOP;
--   INSERT INTO magic_inventory.orders (cards, store_id, user_id, order_status) VALUES (card_array, $2, $3, 'sent');
--   END;
-- $$ LANGUAGE PLPGSQL;
--
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
