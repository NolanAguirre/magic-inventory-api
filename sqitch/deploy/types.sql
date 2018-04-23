-- Deploy magic-inventory:types to pg
-- requires: appschema

BEGIN;

CREATE TYPE card_types AS ENUM{
    'artifact',
    'creature',
    'enchantment',
    'instant',
    'land',
    'planeswalker',
    'sorcery'
}

CREATE TYPE card_condition AS ENUM{
    'mint',
    'near mint',
    'lightly played',
    'moderately played',
    'heavely played',
    'damaged'
}
CREATE TYPE card AS {
    name citext,
    tcg_id integer,
    image text,
    set_name citext,
    set_code citext,
    collectors_number integer,
    condition card_condition,
    variations integer[]
}

COMMIT;
