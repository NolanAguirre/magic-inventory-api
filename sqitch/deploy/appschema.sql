-- Deploy magic-inventory:appschema to pg

BEGIN;

CREATE SCHEMA magic_inventory;

CREATE SCHEMA magic_inventory_private;

COMMIT;
