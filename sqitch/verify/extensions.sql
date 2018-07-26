-- Verify magic-inventory:extensions on pg

BEGIN;

SELECT 1/COUNT(*) FROM pg_extension WHERE extname = 'citext';

SELECT 1/COUNT(*) FROM pg_extension WHERE extname = 'uuid-ossp';

SELECT 1/COUNT(*) FROM pg_extension WHERE extname = 'pgcrypto';

ROLLBACK;
