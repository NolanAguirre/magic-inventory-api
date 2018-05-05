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

CREATE TYPE magic_inventory.magic_card_condition AS ENUM(
    'mint',
    'near mint',
    'lightly played',
    'moderately played',
    'heavely played',
    'damaged'
);

CREATE TYPE magic_inventory.card_status AS ENUM(
    'sold',
    'ordered',
    'hold',
    'available',
    'preorder'
);

CREATE TYPE magic_inventory.role as ENUM(
  'user',
  'employee',
  'store_owner'
);

CREATE TYPE magic_inventory.magic_card AS (
    name citext,
    tcg_id integer,
    image text,
    set_name citext,
    set_code citext,
    collectors_number integer,
    condition magic_inventory.magic_card_condition,
    variations integer[]
);

CREATE TYPE magic_inventory.unique_name_user AS(
    name citext,
    user_id text,
    email citext,
    role magic_inventory.role
);

COMMIT;
