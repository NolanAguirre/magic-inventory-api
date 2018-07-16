-- Revert magic-inventory:privileges from pg

BEGIN;

-- REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM magic_inventory_user;
-- REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM magic_inventory_user;
-- REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM magic_inventory_user;
--
-- REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM magic_inventory_anonymous;
-- REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM magic_inventory_anonymous;
-- REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM magic_inventory_anonymous;
--
-- REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM magic_inventory_employee;
-- REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM magic_inventory_employee;
-- REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM magic_inventory_employee;
--
-- REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM magic_inventory_store_owner;
-- REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM magic_inventory_store_owner;
-- REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM magic_inventory_store_owner;
--
-- REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM magic_inventory_roles;
-- REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM magic_inventory_roles;
-- REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM magic_inventory_roles;

DROP OWNED BY magic_inventory_store_owner;

DROP OWNED BY magic_inventory_user;

DROP OWNED BY magic_inventory_employee;

DROP OWNED BY magic_inventory_anonymous;

DROP OWNED BY magic_inventory_roles;

COMMIT;
