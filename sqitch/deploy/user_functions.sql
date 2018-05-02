-- Deploy magic-inventory:user_functions to pg
-- requires: users
-- requires: appschema
-- requires: types
--requires: extensions

BEGIN;

CREATE FUNCTION magic_inventory.add_user(CITEXT, TEXT, CITEXT) RETURNS BOOLEAN AS $$

  IF SELECT EXISTS(SELECT 1 FROM magic_inventory.users WHERE user.id = $2) THEN
    RETURN SELECT false;
  END IF;

  INSERT INTO magic_inventory.user VALUES ROW($1, $2, $3)::magic_inventory.user;

  IF SELECT EXISTS(SELECT 1 FROM magic_inventory.users WHERE user.id = $2) THEN -- this maybe uneeded
    RETURN SELECT false;
  END IF;

  return SELECT true;
$$ LANGUAGE SQL;

CREATE FUNCTION magic_inventory.delet_user(magic_inventory.user) RETURNS void AS $$
  DELETE FROM magic_inventory.user WHERE user = $1;
$$ LANGUAGE SQL;

COMMIT;
