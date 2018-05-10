-- Deploy magic-inventory:user_functions to pg
-- requires: users
-- requires: appschema
-- requires: types
-- requires: extensions

BEGIN;

--TODO remove return query, change to remove
CREATE FUNCTION magic_inventory.add_user(CITEXT, TEXT, CITEXT) RETURNS SETOF BOOLEAN AS $$

  BEGIN

    IF (SELECT EXISTS(SELECT 1 FROM magic_inventory.users WHERE (app_user).user_id = $2)) THEN
      RETURN QUERY SELECT false;
    END IF;

    INSERT INTO magic_inventory.users VALUES (ROW($1, $2, $3)::magic_inventory.user_type);

    IF (SELECT EXISTS(SELECT 1 FROM magic_inventory.users WHERE (app_user).user_id = $2)) THEN -- this maybe uneeded
      RETURN QUERY SELECT false;
    END IF;

    RETURN QUERY SELECT true;

  END

$$ LANGUAGE PLPGSQL;

CREATE FUNCTION magic_inventory.remove_user(TEXT) RETURNS void AS $$
  DELETE FROM magic_inventory.users WHERE (app_user).user_id = $1;
$$ LANGUAGE SQL;

COMMIT;
