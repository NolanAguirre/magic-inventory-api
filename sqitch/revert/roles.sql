-- Revert magic-inventory:roles from pg

BEGIN;

DROP ROLE magic_inventory_user;

DROP ROLE magic_inventory_employee;

DROP ROLE magic_inventory_anonymous;

DROP ROLE magic_inventory_store_owner;

DROP ROLE magic_inventory_roles;

COMMIT;
