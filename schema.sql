-- View table structures
PRAGMA table_info(events);
PRAGMA table_info(transactions);
PRAGMA table_info(campaign);
PRAGMA table_info(customers);
PRAGMA table_info(products);

-- Explore event types
SELECT DISTINCT event_type FROM events;

-- Check traffic sources
SELECT DISTINCT traffic_source FROM events;

-- Basic row counts
SELECT COUNT(*) FROM events;
SELECT COUNT(*) FROM transactions;