-- Placeholder migration for previously applied step 0004_minor_dracula
-- This file exists to satisfy the migration journal.
-- Implemented as a no-op using a create/drop of a temp table to keep schema unchanged.

CREATE TABLE IF NOT EXISTS "__drizzle_noop_0004" (x integer);
--e statement-breakpoint
DROP TABLE IF EXISTS "__drizzle_noop_0004";

