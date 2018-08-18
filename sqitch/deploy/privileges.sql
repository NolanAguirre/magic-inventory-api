-- Deploy magic-inventory:privileges to pg
-- requires: appschema
-- requires: roles
-- requires inventory_functions

BEGIN;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON functions FROM public;
-- schema
GRANT USAGE ON SCHEMA magic_inventory TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
-- functions
GRANT EXECUTE ON FUNCTION citext_eq(citext, citext) TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION texticregexeq (citext, citext) TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION uuid_generate_v4() TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION texticlike(citext, citext) TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.get_role() TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.authenticate(CITEXT, TEXT) TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.register_user(CITEXT, CITEXT, CITEXT, TEXT) TO magic_inventory_anonymous;
GRANT EXECUTE ON FUNCTION magic_inventory.inventory_typeahead(arg_one CITEXT , arg_two UUID) TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.inventory_by_card_name_and_store_id(arg_one CITEXT, arg_two UUID) TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.update_role(UUID, magic_inventory.role_type) TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.get_id() TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.get_admin_store() TO magic_inventory_employee, magic_inventory_store_owner;
GRANT EXECUTE ON FUNCTION magic_inventory.get_user_data() TO magic_inventory_employee, magic_inventory_store_owner, magic_inventory_user;

-- views
GRANT SELECT ON TABLE magic_inventory.card_name TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT SELECT ON TABLE magic_inventory.card_set TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
-- admins table
GRANT INSERT, DELETE, SELECT ON TABLE magic_inventory.admins TO magic_inventory_store_owner;
-- cards table
GRANT SELECT ON TABLE magic_inventory.cards TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
-- stores table
GRANT SELECT (name, id, email, phone_number) ON TABLE magic_inventory.stores TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT SELECT, UPDATE (client_settings) ON TABLE magic_inventory.stores TO magic_inventory_employee, magic_inventory_store_owner;
GRANT INSERT ON TABLE magic_inventory.stores TO magic_inventory_store_owner;
-- orders table
GRANT INSERT, SELECT ON TABLE magic_inventory.orders TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
GRANT UPDATE (order_status) ON TABLE magic_inventory.orders TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
-- order items table
GRANT INSERT, SELECT ON TABLE magic_inventory.order_items TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
-- inventory items table
GRANT SELECT ON TABLE magic_inventory.inventory TO magic_inventory_user, magic_inventory_anonymous, magic_inventory_employee, magic_inventory_store_owner;
GRANT INSERT ON TABLE magic_inventory.inventory TO magic_inventory_employee, magic_inventory_store_owner;
GRANT UPDATE (status) ON TABLE magic_inventory.inventory TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
-- users table
GRANT INSERT ON TABLE magic_inventory.users TO magic_inventory_anonymous;
GRANT SELECT (first_name, last_name, id) ON TABLE magic_inventory.users TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
GRANT DELETE ON TABLE magic_inventory.users TO magic_inventory_user, magic_inventory_employee, magic_inventory_store_owner;
-- row level needed:
-- inventory, stores can only add and remove from their stores
-- orders, users, and stores can only add to their orders, via checking if they belong to the store, or the person is the person who placed the order
-- stores, employees can only edit stores to which they are admins in
-- users can only delete their own profile
COMMIT;
