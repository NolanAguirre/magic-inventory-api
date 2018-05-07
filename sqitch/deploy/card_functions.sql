-- Deploy magic-inventory:card_functions to pg
-- requires: types

BEGIN;
-- used to get the complete data of a card from the given json object
CREATE FUNCTION magic_inventory.create_card(json) RETURNS magic_inventory.card AS $$

$$ LANGUAGE SQL;

COMMIT;
