-- Revert magic-inventory:user_functions from pg

BEGIN;

DROP FUNCTION magic_inventory.register_user(
    first_name citext,
    last_name citext,
    user_name citext,
    email citext,
    password text);

DROP FUNCTION magic_inventory.authenticate(
  email CITEXT,
  password text);
COMMIT;
