-- Deploy magic-inventory:privileges to pg
-- requires: appschema
-- requires: roles

BEGIN;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON functions FROM public;

GRANT USAGE ON SCHEMA magic_inventory TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;

GRANT SELECT ON TABLE magic_inventory.cards TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;

GRANT SELECT ON TABLE magic_inventory.cards TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;

GRANT SELECT ON TABLE magic_inventory.inventory TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT  DELETE ON TABLE magic_inventory.inventory TO magic_inventory_employee, magic_inventory_store_owner; --insert via function

GRANT SELECT ON TABLE magic_inventory.orders TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
GRANT UPDATE ON TABLE magic_inventory.orders TO magic_inventory_employee, magic_inventory_store_owner; -- insert via function

GRANT SELECT ON TABLE magic_inventory.stores TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT UPDATE (admins) ON TABLE magic_inventory.stores TO magic_inventory_store_owner;
GRANT UPDATE (client_settings) ON TABLE magic_inventory.stores TO magic_inventory_employee, magic_inventory_store_owner;

-- this needs some thinkin done before i do this

COMMIT;
