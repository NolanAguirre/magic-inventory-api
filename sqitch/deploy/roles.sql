-- Deploy magic-inventory:roles to pg

BEGIN;

CREATE ROLE magic_inventory_roles LOGIN PASSWORD 'potato'; --temporary password

CREATE ROLE magic_inventory_anonymous;

GRANT magic_inventory_anonymous TO magic_inventory_roles;

CREATE ROLE magic_inventory_user;

GRANT magic_inventory_user TO magic_inventory_roles;

CREATE ROLE magic_inventory_store_owner;

GRANT magic_inventory_store_owner TO magic_inventory_roles;

CREATE ROLE magic_inventory_employee;

GRANT magic_inventory_employee TO magic_inventory_roles;

COMMIT;
