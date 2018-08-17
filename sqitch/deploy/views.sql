-- Deploy magic-inventory:views to pg
-- requires: cards

BEGIN;

CREATE VIEW magic_inventory.card_name AS SELECT DISTINCT name FROM magic_inventory.cards;

CREATE VIEW magic_inventory.card_set AS SELECT DISTINCT set_name FROM magic_inventory.cards;

CREATE VIEW magic_inventory.inventory_card_set AS SELECT
DISTINCT magic_inventory.cards.set_name,
magic_inventory.inventory.store_id
FROM magic_inventory.inventory
INNER JOIN magic_inventory.cards ON (magic_inventory.inventory.card_id = magic_inventory.cards.id);

CREATE VIEW magic_inventory.inventory_card_name AS SELECT
DISTINCT magic_inventory.cards.name,
magic_inventory.inventory.store_id
FROM magic_inventory.inventory
INNER JOIN magic_inventory.cards ON (magic_inventory.inventory.card_id = magic_inventory.cards.id);

-- CREATE VIEW magic_inventory.inventory_card
COMMIT;

-- create view magic_inventory.test_view as select
--     magic_inventory.inventory.store_id,
--     magic_inventory.inventory.condition,
--     magic_inventory.inventory.price,
--     magic_inventory.stores.name as store_name,
--     magic_inventory.stores.city,
--     magic_inventory.cards.* from magic_inventory.inventory
--      inner join magic_inventory.cards on (magic_inventory.inventory.card_id=magic_inventory.cards.id)
--      inner join magic_inventory.stores on (magic_inventory.inventory.store_id=magic_inventory.stores.id);
