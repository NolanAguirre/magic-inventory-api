-- Deploy magic-inventory:inventory_functions to pg
-- requires: inventory

BEGIN;

CREATE FUNCTION magic_inventory.inventory_typeahead(arg_one CITEXT , arg_two UUID) RETURNS SETOF CITEXT AS $$ -- used for the client
  BEGIN
  RETURN QUERY SELECT DISTINCT name FROM magic_inventory.cards WHERE id in (SELECT card_id FROM magic_inventory.inventory WHERE store_id = $2) AND name LIKE $1 LIMIT 10;
  END;
$$ LANGUAGE PLPGSQL STABLE;

CREATE FUNCTION magic_inventory.inventory_by_card_name_and_store_id(arg_one CITEXT, arg_two UUID) RETURNS SETOF magic_inventory.inventory AS $$ -- used for the client
  BEGIN
  RETURN QUERY SELECT * FROM magic_inventory.inventory WHERE card_id in (SELECT id FROM magic_inventory.cards WHERE name = $1) AND store_id = $2 ORDER BY condition ASC;
  END;
$$ LANGUAGE PLPGSQL STABLE;

CREATE FUNCTION magic_inventory.admin_add_inventory(UUID, magic_inventory.card_condition_type, magic_inventory.card_status_type, FLOAT) RETURNS VOID AS $$
    INSERT INTO magic_inventory.inventory (card_id, store_id, condition,status, price) VALUES ($1, magic_inventory.get_admin_store(), $2,$3,$4);
$$ LANGUAGE SQL STRICT;

CREATE FUNCTION magic_inventory.admin_inventory_typeahead(arg_one CITEXT) RETURNS SETOF CITEXT AS $$ -- used for the client
  BEGIN
    RETURN QUERY SELECT * FROM magic_inventory.inventory_typeahead($1, magic_inventory.get_admin_store());
  END;
$$ LANGUAGE PLPGSQL STABLE;

CREATE FUNCTION magic_inventory.admin_inventory_by_card_name_and_store_id(arg_one CITEXT) RETURNS SETOF magic_inventory.inventory AS $$ -- used for the client
  BEGIN
  RETURN QUERY SELECT * FROM magic_inventory.inventory_by_card_name_and_store_id($1, magic_inventory.get_admin_store());
  END;
$$ LANGUAGE PLPGSQL STABLE;

COMMENT ON FUNCTION magic_inventory.inventory_typeahead(CITEXT, UUID) is 'Typeahead for a stores inventory';
COMMENT ON FUNCTION magic_inventory.inventory_by_card_name_and_store_id(CITEXT, UUID) is 'Custom function for querying a stores inventory for a card';

-- TODO make this work like postgraphile queries, that accept json and work magically like
COMMIT;
