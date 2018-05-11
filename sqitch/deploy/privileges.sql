-- Deploy magic-inventory:privileges to pg
-- requires: appschema
-- requires: roles

BEGIN;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON functions FROM public;

GRANT USAGE ON SCHEMA magic_inventory TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;

GRANT SELECT ON TABLE magic_inventory.cards TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;

GRANT SELECT ON TABLE magic_inventory.inventory TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT DELETE ON TABLE magic_inventory.inventory TO magic_inventory_employee, magic_inventory_store_owner; --insert and delete via function

GRANT SELECT ON TABLE magic_inventory.orders TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
GRANT UPDATE ON TABLE magic_inventory.orders TO magic_inventory_employee, magic_inventory_store_owner; -- insert via function, trigger needed

GRANT SELECT (store_name, store_id) ON TABLE magic_inventory.stores TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT SELECT (client_settings), UPDATE (client_settings) ON TABLE magic_inventory.stores TO magic_inventory_employee, magic_inventory_store_owner;
GRANT SELECT (admins) , UPDATE (admins) ON TABLE magic_inventory.stores TO magic_inventory_store_owner;

GRANT EXECUTE ON FUNCTION magic_inventory.add_user(CITEXT, TEXT, CITEXT) TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.remove_user(TEXT) TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;

GRANT EXECUTE ON FUNCTION magic_inventory.add_inventory(json[], TEXT) TO magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.remove_inventory(json[], TEXT) TO magic_inventory_employee, magic_inventory_store_owner;


-- row level needed:
-- inventory, stores can only add and remove from their stores
-- orders, users, and stores can only add to their orders, via checking if they belong to the store, or the person is the person who placed the order
-- stores, employees can only edit stores to which they are admins in
-- users can only delete their own profile
COMMIT;
