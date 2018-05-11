-- Deploy magic-inventory:types to pg
-- requires: appschema
-- requires: extensions

BEGIN;

CREATE TYPE magic_inventory.card_type_type AS ENUM(
    'artifact',
    'creature',
    'enchantment',
    'instant',
    'land',
    'planeswalker',
    'sorcery'
);

CREATE TYPE magic_inventory.card_condition_type AS ENUM(
    'mint',
    'near mint',
    'lightly played',
    'moderately played',
    'heavely played',
    'damaged'
);

CREATE TYPE magic_inventory.card_status_type AS ENUM(
    'ordered',
    'sold',
    'requested',
    'reference card',
    'available',
    'preorder'
);
CREATE TYPE magic_inventory.order_status_type AS ENUM(
  'sent',
  'recived',
  'ready',
  'complete',
  'cancled',
  'unfulfillable'
);
CREATE TYPE magic_inventory.role_type as ENUM( --may not need, more to keep track of the roles that to actually be used
  'user',
  'employee',
  'store_owner'
);

CREATE TYPE magic_inventory.magic_card_type AS (
    name citext,
    tcg_id integer,
    image text,
    card_set citext,
    set_code citext,
    set_name citext,
    collectors_number integer,
    condition magic_inventory.card_condition_type,
    variations integer[]
);
CREATE TYPE magic_inventory.inventory_card_type AS (
  quantity INTEGER
) INHERITS (magic_inventory.magic_card_type);

CREATE TYPE magic_inventory.user_type AS(
    name citext,
    user_id text,
    email citext--,
    --role magic_inventory.role --may not need
);

COMMIT;
