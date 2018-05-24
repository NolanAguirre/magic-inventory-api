-- Deploy magic-inventory:inventory_functions to pg
-- requires: inventory

BEGIN;

CREATE FUNCTION magic_inventory.add_inventory(arg_cards_data json[], arg_store_id UUID) RETURNS VOID AS $$ -- used for the client
  DECLARE
    json_card json;
  BEGIN
    FOR json_card IN SELECT * FROM json_array_elements($1)
    LOOP
        INSERT INTO magic_inventory.inventory (card_id, store_id, condition) VALUES (json_card.cardId, arg_store_id, json_card.cardCondition);
    END LOOP;
  END;
$$ LANGUAGE PLPGSQL;

-- CREATE FUNCTION magic_inventory.add_inventory(arg_order_id UUID) RETURNS VOID AS $$ -- used for orders being canced
--   INSERT INTO magic_inventory.inventory (card_id, store_id, condition) SELECT card_id, store_id, condition FROM magic_inventory.orders WHERE arg_order_id = $1;
-- $$ LANGUAGE SQL;

CREATE FUNCTION magic_inventory.remove_inventory(arg_card_ids UUID[]) RETURNS VOID AS $$ -- used for the client to manually remove inventory
  DECLARE
    card_id UUID;
  BEGIN
    FOREACH card_id IN ARRAY $1
    LOOP
        DELETE FROM magic_inventory.inventory WHERE id = $1;
    END LOOP;
  END;
$$ LANGUAGE PLPGSQL;

-- CREATE FUNCTION magic_inventory.remove_inventory(arg_card_id UUID) RETURNS VOID AS $$ -- used for orders
--   DELETE FROM magic_inventory.inventory WHERE id = $1;
-- $$ LANGUAGE SQL;
-- COMMENT ON FUNCTION magic_inventory.add_inventory(json[], TEXT) is 'Accepts json array of cards and adds them to the stores inventory';
-- COMMENT ON FUNCTION magic_inventory.add_inventory(magic_inventory.inventory_card_type[], TEXT) is 'Internal use only.';
-- COMMENT ON FUNCTION magic_inventory.add_inventory(magic_inventory.inventory_card_type, TEXT) is 'Internal use only.';
-- COMMENT ON FUNCTION magic_inventory.remove_inventory(json[], TEXT) is 'Accepts json array of cards and removes them to the stores inventory';

COMMIT;
