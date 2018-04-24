-- Verify magic-inventory:extensions on pg

BEGIN;

SELECT 1/COUNT(*) FROM pg_extension WHERE extname = 'citext';

ROLLBACK;
