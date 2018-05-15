-- Deploy magic-inventory:store_functions to pg
-- requires: stores

BEGIN;

CREATE FUNCTION magic_inventory.create_store(arg_store_name citext) RETURNS NULL AS $$

$$ LANGUAGE SQL;

CREATE FUNCTION magic_inventory.update_store_settings(arg_settings json) RETURNS NULL AS $$

$$ LANGUAGE SQL;

CREATE FUNCTION magic_inventory.delete_store(arg_store_id TEXT) RETURNS NULL as $$

$$ LANGUAGE SQL;
COMMIT;
