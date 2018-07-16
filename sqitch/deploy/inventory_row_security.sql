-- Deploy magic-inventory:inventory_row_security to pg
-- requires: inventory

BEGIN;

ALTER TABLE magic_inventory.inventory ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY account_managers ON magic_inventory.inventory TO magic_inventory_employee USING ( = current_user);

COMMIT;
