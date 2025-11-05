CREATE DATABASE IF NOT EXISTS musicbase_db;
USE musicbase_db;

-- Query 1: Top 5 Artists by Monthly Listeners
SELECT artist_name, monthly_listeners
FROM artists
ORDER BY monthly_listeners DESC
LIMIT 5;

