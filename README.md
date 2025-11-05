# MusicBase – Milestone 2: Data Population, Queries, and Automation

## Overview

MusicBase is a relational database designed to model a music streaming platform, similar to Spotify or Apple Music. This milestone focuses on:

1. Implementing the database schema with all tables, relationships, and constraints.
2. Populating the tables with realistic sample data.
3. Demonstrating database functionality using queries (CRUD, joins, aggregates).
4. Implementing at least one trigger and one stored procedure to automate tasks and enforce business rules.

---

## Folder & File Structure

```
lab3_music_db/
├── create_and_populate.sql        # Schema creation + sample data inserts
├── queries.sql                    # 5–10 sample queries demonstrating CRUD, joins, and aggregate functions
├── automation.sql                 # Trigger + stored procedure with business logic
└── lab3_music_db_backup.sql       # Full MySQL Workbench export (structure + data + triggers + procedures)
```

---

## File Descriptions

### 1. `create_and_populate.sql`

-   Creates the following tables:

    -   `User`, `Artist`, `Album`, `Song`, `Review`, `Follow`, `ReviewLike`

-   Includes primary keys, foreign keys, and constraints such as uniqueness and rating checks.
-   Populates each table with sample data (10–20 rows per table).

### 2. `queries.sql`

-   Demonstrates database functionality with examples of:

    -   **CRUD operations** (INSERT, SELECT, UPDATE, DELETE)
    -   **Joins** (e.g., Artist ↔ Song ↔ Album, User ↔ Review)
    -   **Aggregate functions** (AVG rating, COUNT followers, etc.)

### 3. `automation.sql`

-   Contains **one trigger**:

    -   Example: Automatically updates a song’s rating when a new review is added.

-   Contains **one stored procedure**:

    -   Example: Retrieves the top-rated songs for a given genre or a user’s reviews.

-   Includes inline comments explaining purpose and logic.

### 4. `lab3_music_db_backup.sql`

-   Full export from MySQL Workbench including:

    -   Table structure
    -   Sample data
    -   Triggers
    -   Stored procedures

---

## How to Use

1. Open **MySQL Workbench** or any SQL client.
2. Run `create_and_populate.sql` to create the database and populate it with sample data.
3. Run `queries.sql` to test CRUD operations, joins, and aggregates.
4. Run `automation.sql` to add triggers and stored procedures.
5. Optionally, import `lab3_music_db_backup.sql` to restore the full database with all objects and data.

---

## Notes

-   All tables follow the business rules provided by the team, including:

    -   Unique usernames, emails, and IDs
    -   One review per user per song
    -   Follow relationships and review likes constraints

-   Triggers and stored procedures are documented with their purpose and usage examples in `automation.sql`.
