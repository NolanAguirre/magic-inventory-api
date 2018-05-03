-- Verify magic-inventory:user_functions on pg

BEGIN;

SELECT has_function_privilege('magic_inventory.add_user(citext, text, citext)', 'execute');

SELECT has_function_privilege('magic_inventory.remove_user(magic_inventory.user)', 'execute');

ROLLBACK;
