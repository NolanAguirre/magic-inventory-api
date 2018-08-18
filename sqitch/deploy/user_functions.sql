-- Deploy magic-inventory:user_functions to pg
-- requires: users_private

BEGIN;

CREATE FUNCTION magic_inventory.register_user(
    first_name citext,
    last_name citext,
    email citext,
    password text) RETURNS magic_inventory.users AS $$
    DECLARE
        person magic_inventory.users;
    BEGIN
        INSERT INTO magic_inventory.users (first_name, last_name) VALUES ($1, $2) returning * into person;
        INSERT INTO magic_inventory_private.users(user_id, email, password_hash, role) VALUES ((person).id, $3, crypt($4, gen_salt('bf')), 'magic_inventory_user');
        RETURN person;
    END;
$$ LANGUAGE PLPGSQL STRICT SECURITY DEFINER;


CREATE OR REPLACE FUNCTION magic_inventory.authenticate(CITEXT, password text) RETURNS magic_inventory.jwt_token_type AS $$
  DECLARE
    person magic_inventory_private.users;
    public_person magic_inventory.users;
    BEGIN
        select a.* into person
        from magic_inventory_private.users as a
        where a.email = $1;
        select a.* into public_person
        from magic_inventory.users as a
        where a.id = person.user_id;
        IF (person).password_hash = crypt(password, (person).password_hash) then
            RETURN((person).role, null, (public_person).id)::magic_inventory.jwt_token_type;
        ELSE
            RETURN null;
        END IF;
    END;
$$ LANGUAGE PLPGSQL STRICT SECURITY DEFINER;

CREATE FUNCTION magic_inventory.update_role(UUID, magic_inventory.role_type) RETURNS VOID AS $$
    UPDATE magic_inventory_private.users SET role = $2 WHERE user_id = $1;
$$ LANGUAGE SQL STRICT SECURITY DEFINER;

CREATE FUNCTION magic_inventory.get_user_data() RETURNS magic_inventory.user_type AS $$
    DECLARE
        person magic_inventory.users;
    BEGIN
        select a.* into person from magic_inventory.users as a where a.id = magic_inventory.get_id();
        RETURN ROW(person.first_name, person.last_name, magic_inventory.get_admin_store(), magic_inventory.get_role(), current_setting('jwt.claims.expires_at', true), magic_inventory.get_id())::magic_inventory.user_type;
    END;
$$ LANGUAGE PLPGSQL STABLE;

CREATE FUNCTION magic_inventory.get_role() RETURNS magic_inventory.role_type AS $$
    SELECT nullif(current_setting('jwt.claims.role', true),'')::magic_inventory.role_type;
$$ LANGUAGE SQL;

CREATE FUNCTION magic_inventory.get_id() RETURNS UUID AS $$
    SELECT uuid(current_setting('jwt.claims.id', true));
$$ LANGUAGE SQL;

COMMIT;
