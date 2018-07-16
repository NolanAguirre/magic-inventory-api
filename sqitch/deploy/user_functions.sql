-- Deploy magic-inventory:user_functions to pg
-- requires: users
-- requires: appschema
-- requires: types
-- requires: extensions
-- requires: users_private

BEGIN;

CREATE FUNCTION magic_inventory.register_user(
    first_name citext,
    last_name citext,
    user_name citext,
    email citext,
    password text) RETURNS magic_inventory.users AS $$
    DECLARE
        person magic_inventory.users;
    BEGIN
        INSERT INTO magic_inventory.users (first_name, last_name, user_name) VALUES ($1, $2, $3) returning * into person;
        INSERT INTO magic_inventory_private.users(user_id, email, password_hash, role) VALUES ((person).id, $4, crypt(password, gen_salt('bf')), 'magic_inventory_user');
        RETURN person;
    END;
$$ LANGUAGE PLPGSQL STRICT SECURITY DEFINER;


CREATE FUNCTION magic_inventory.authenticate(
  CITEXT,
  password text) RETURNS magic_inventory.jwt_token_type AS $$
  DECLARE
    person magic_inventory_private.users;
    BEGIN
        select a.* into person
        from magic_inventory_private.users as a
        where a.email = $1;
        IF (person).password_hash = crypt(password, (person).password_hash) then
            RETURN((person).role, null, null, (person).email)::magic_inventory.jwt_token_type;
        ELSE
            RETURN null;
        END IF;
    END;
$$ LANGUAGE PLPGSQL STRICT SECURITY DEFINER;


COMMIT;
