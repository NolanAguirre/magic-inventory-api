-- Deploy magic-inventory:card_functions to pg
-- requires: types

BEGIN;

CREATE FUNCTION magic_inventory.typeahead(arg_card_name CITEXT) RETURNS SETOF CITEXT AS $$
  BEGIN
    RETURN QUERY SELECT DISTINCT name FROM magic_inventory.cards WHERE name LIKE $1 || '%' LIMIT 10;
  END;
$$ LANGUAGE PLPGSQL STABLE;

COMMENT ON FUNCTION magic_inventory.typeahead(CITEXT) is 'Typeahead query function.';

COMMIT;

-- {
--  	typeahead(argCardName:"a"){
--     edges{
--       node
--     }
--   }
-- }
