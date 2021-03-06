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
CREATE TYPE magic_inventory.order_status_type AS ENUM( -- this needs to change
  'sent',
  'recived',
  'ready',
  'complete',
  'cancled',
  'unfulfillable'
);
CREATE TYPE magic_inventory.role_type as ENUM(
  'magic_inventory_anonymous',
  'magic_inventory_user',
  'magic_inventory_employee',
  'magic_inventory_store_owner'
);

CREATE TYPE magic_inventory.jwt_token_type AS (
  role magic_inventory.role_type,
  expires_at integer,
  id UUID
);

CREATE TYPE magic_inventory.user_type AS (
    first_name CITEXT,
    last_name CITEXT,
    store UUID,
    role magic_inventory.role_type,
    expires_at INTEGER,
    id UUID
);

CREATE TYPE magic_inventory.state_type AS ENUM(
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Louisiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennsylvania',
  'Rhode Island',
  'South Carolina',
  'South Dakota',
  'Tennessee',
  'Texas',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virginia',
  'Wisconsin',
  'Wyoming'
);

COMMIT;
