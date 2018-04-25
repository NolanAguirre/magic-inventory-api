-- Deploy magic-inventory:types to pg
-- requires: appschema
-- requires: extensions

BEGIN;

CREATE TYPE magic_inventory.card_type AS ENUM(
    'artifact',
    'creature',
    'enchantment',
    'instant',
    'land',
    'planeswalker',
    'sorcery'
);

CREATE TYPE magic_inventory.card_condition AS ENUM(
    'mint',
    'near mint',
    'lightly played',
    'moderately played',
    'heavely played',
    'damaged'
);

CREATE TYPE magic_inventory.card AS (
    name citext,
    tcg_id integer,
    image text,
    set_name citext,
    set_code citext,
    collectors_number integer,
    condition magic_inventory.card_condition,
    variations integer[]
);

CREATE TYPE magic_inventory.user AS(
    name citext,
    id text,
    email citext
);

COMMIT;
