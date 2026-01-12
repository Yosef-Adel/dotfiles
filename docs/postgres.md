# PostgreSQL Reference

Quick reference for PostgreSQL (relational database). Use `/` to search in vim.

## Table of Contents

- [PostgreSQL Reference](#postgresql-reference)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Connection](#connection)
    - [psql](#psql)
    - [Connection String](#connection-string)
  - [Database Management](#database-management)
    - [Create Database](#create-database)
    - [List Databases](#list-databases)
    - [Drop Database](#drop-database)
    - [Backup \& Restore](#backup--restore)
  - [Tables](#tables)
    - [Create Table](#create-table)
    - [Data Types](#data-types)
    - [Constraints](#constraints)
    - [Alter Table](#alter-table)
    - [Drop Table](#drop-table)
  - [Queries](#queries)
    - [SELECT](#select)
    - [WHERE](#where)
    - [JOIN](#join)
    - [GROUP BY](#group-by)
    - [ORDER BY](#order-by)
    - [LIMIT \& OFFSET](#limit--offset)
  - [Data Manipulation](#data-manipulation)
    - [INSERT](#insert)
    - [UPDATE](#update)
    - [DELETE](#delete)
    - [UPSERT](#upsert)
  - [Aggregation](#aggregation)
    - [Aggregate Functions](#aggregate-functions)
    - [Window Functions](#window-functions)
  - [Indexes](#indexes)
  - [Views](#views)
  - [Transactions](#transactions)
  - [Users \& Permissions](#users--permissions)
  - [Common Operations](#common-operations)

## Installation

Install PostgreSQL.

```bash
# macOS (Homebrew)
brew install postgresql@15
brew services start postgresql@15

# Ubuntu/Debian
sudo apt-get install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Docker
docker run --name postgres -e POSTGRES_PASSWORD=secret -p 5432:5432 -d postgres:15
```

## Connection

### psql

Connect to database using psql CLI.

```bash
# Connect to local database
psql -U postgres
psql -U postgres -d mydb

# Connect to remote database
psql -h hostname -U username -d database
psql -h 192.168.1.100 -U postgres -d mydb -p 5432

# Connect via connection string
psql "postgresql://user:password@localhost:5432/dbname"

# Execute command
psql -U postgres -c "SELECT version();"

# Execute file
psql -U postgres -f script.sql
```

### Connection String

```
postgresql://user:password@localhost:5432/dbname

# Components
postgresql://          # Protocol
user:password         # Credentials
localhost            # Host
5432                # Port (optional, default)
/dbname              # Database name
```

```bash
# Environment variable
export DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
psql $DATABASE_URL
```

## Database Management

### Create Database

```sql
CREATE DATABASE mydb;
CREATE DATABASE mydb OWNER myuser;
CREATE DATABASE mydb ENCODING 'UTF8' LOCALE 'en_US.UTF-8';

-- With connection limit
CREATE DATABASE mydb WITH CONNECTION LIMIT 100;
```

### List Databases

```bash
# In psql
\l
\list

# Via SQL
SELECT datname FROM pg_database WHERE datistemplate = false;
```

### Drop Database

```sql
DROP DATABASE mydb;
DROP DATABASE IF EXISTS mydb;

-- Force drop (terminate connections)
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'mydb';

DROP DATABASE mydb;
```

### Backup & Restore

```bash
# Backup database
pg_dump mydb > backup.sql
pg_dump -U username -d mydb > backup.sql

# Backup to custom format
pg_dump -Fc mydb > backup.dump

# Restore
psql mydb < backup.sql
pg_restore -d mydb backup.dump

# List backup contents
pg_restore -l backup.dump
```

## Tables

### Create Table

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  age INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- With constraints
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(200) NOT NULL,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT posts_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Data Types

```sql
-- Numeric
INTEGER, INT, SMALLINT, BIGINT
DECIMAL(10, 2), NUMERIC(10, 2)
FLOAT, DOUBLE PRECISION
SERIAL, BIGSERIAL               -- Auto-incrementing integers

-- String
VARCHAR(n), CHAR(n), TEXT
CHAR VARYING(n)                 -- Same as VARCHAR

-- Date & Time
DATE
TIME
TIMESTAMP, TIMESTAMP WITH TIME ZONE
INTERVAL                         -- Time intervals

-- Boolean
BOOLEAN

-- JSON
JSON, JSONB                      -- JSON data

-- Binary
BYTEA                            -- Binary data

-- UUID
UUID

-- Array
INTEGER[], TEXT[]

-- Enum
CREATE TYPE status AS ENUM ('pending', 'active', 'inactive');
```

### Constraints

```sql
-- Primary Key
CREATE TABLE users (
  id INT PRIMARY KEY,
  email VARCHAR(100)
);

-- Unique constraint
CREATE TABLE users (
  email VARCHAR(100) UNIQUE,
  username VARCHAR(50) UNIQUE
);

-- NOT NULL
CREATE TABLE users (
  name VARCHAR(100) NOT NULL
);

-- Foreign Key
CREATE TABLE posts (
  user_id INT REFERENCES users(id)
);

-- ON DELETE options
REFERENCES users(id) ON DELETE CASCADE      -- Delete if parent deleted
REFERENCES users(id) ON DELETE SET NULL    -- Set to NULL if parent deleted
REFERENCES users(id) ON DELETE RESTRICT    -- Prevent delete if child exists

-- Check constraint
CREATE TABLE users (
  age INT CHECK (age >= 0),
  status VARCHAR(20) CHECK (status IN ('active', 'inactive'))
);

-- Default value
CREATE TABLE posts (
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) DEFAULT 'draft'
);
```

### Alter Table

```sql
-- Add column
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Drop column
ALTER TABLE users DROP COLUMN phone;

-- Rename column
ALTER TABLE users RENAME COLUMN old_name TO new_name;

-- Change column type
ALTER TABLE users ALTER COLUMN age TYPE SMALLINT;

-- Add constraint
ALTER TABLE users ADD CONSTRAINT email_unique UNIQUE (email);

-- Drop constraint
ALTER TABLE users DROP CONSTRAINT email_unique;

-- Add default
ALTER TABLE users ALTER COLUMN status SET DEFAULT 'active';

-- Remove default
ALTER TABLE users ALTER COLUMN status DROP DEFAULT;

-- Rename table
ALTER TABLE old_name RENAME TO new_name;
```

### Drop Table

```sql
DROP TABLE users;
DROP TABLE IF EXISTS users;

-- Cascade (drop dependent objects)
DROP TABLE users CASCADE;
```

## Queries

### SELECT

```sql
-- Basic
SELECT * FROM users;
SELECT id, name, email FROM users;

-- With alias
SELECT id AS user_id, name AS full_name FROM users;
SELECT u.id, u.name FROM users u;

-- Distinct
SELECT DISTINCT city FROM users;

-- Case
SELECT name,
  CASE WHEN age >= 18 THEN 'Adult' ELSE 'Minor' END AS status
FROM users;
```

### WHERE

```sql
-- Comparison
SELECT * FROM users WHERE age > 18;
SELECT * FROM users WHERE age BETWEEN 18 AND 65;

-- String matching
SELECT * FROM users WHERE name LIKE 'J%';      -- Starts with J
SELECT * FROM users WHERE name LIKE '%n';      -- Ends with n
SELECT * FROM users WHERE name LIKE '%oh%';    -- Contains oh
SELECT * FROM users WHERE name ILIKE 'john';   -- Case insensitive

-- IN
SELECT * FROM users WHERE status IN ('active', 'pending');

-- IS NULL
SELECT * FROM users WHERE phone IS NULL;
SELECT * FROM users WHERE phone IS NOT NULL;

-- Logical operators
SELECT * FROM users WHERE age > 18 AND status = 'active';
SELECT * FROM users WHERE age < 18 OR status = 'inactive';
SELECT * FROM users WHERE NOT status = 'deleted';
```

### JOIN

```sql
-- INNER JOIN (default)
SELECT u.name, p.title
FROM users u
INNER JOIN posts p ON u.id = p.user_id;

-- LEFT JOIN
SELECT u.name, COUNT(p.id)
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.id;

-- RIGHT JOIN
SELECT u.name, p.title
FROM users u
RIGHT JOIN posts p ON u.id = p.user_id;

-- FULL OUTER JOIN
SELECT u.name, p.title
FROM users u
FULL OUTER JOIN posts p ON u.id = p.user_id;

-- CROSS JOIN
SELECT u.name, c.category
FROM users u
CROSS JOIN categories c;

-- Self join
SELECT a.name AS employee, b.name AS manager
FROM users a
JOIN users b ON a.manager_id = b.id;
```

### GROUP BY

```sql
-- Count by group
SELECT status, COUNT(*) FROM users GROUP BY status;

-- Multiple columns
SELECT status, age_group, COUNT(*)
FROM users
GROUP BY status, age_group;

-- With HAVING (filter groups)
SELECT status, COUNT(*) as count
FROM users
GROUP BY status
HAVING COUNT(*) > 5;

-- Aggregation
SELECT
  city,
  COUNT(*) as user_count,
  AVG(age) as avg_age,
  MAX(salary) as max_salary
FROM users
GROUP BY city;
```

### ORDER BY

```sql
-- Ascending (default)
SELECT * FROM users ORDER BY name;
SELECT * FROM users ORDER BY name ASC;

-- Descending
SELECT * FROM users ORDER BY age DESC;

-- Multiple columns
SELECT * FROM users ORDER BY status ASC, name ASC;

-- NULLS handling
SELECT * FROM users ORDER BY phone NULLS LAST;
SELECT * FROM users ORDER BY phone NULLS FIRST;
```

### LIMIT & OFFSET

```sql
-- Limit
SELECT * FROM users LIMIT 10;

-- Offset
SELECT * FROM users LIMIT 10 OFFSET 20;

-- Pagination
SELECT * FROM users ORDER BY id LIMIT 10 OFFSET (page - 1) * 10;

-- Shorthand
SELECT * FROM users LIMIT 10 OFFSET 20;
SELECT * FROM users OFFSET 20 LIMIT 10;  -- Same
SELECT * FROM users LIMIT 10, 20;        -- Old MySQL syntax (not standard)
```

## Data Manipulation

### INSERT

```sql
-- Single row
INSERT INTO users (name, email, age)
VALUES ('John', 'john@example.com', 30);

-- Multiple rows
INSERT INTO users (name, email, age)
VALUES
  ('John', 'john@example.com', 30),
  ('Jane', 'jane@example.com', 28),
  ('Bob', 'bob@example.com', 35);

-- From SELECT
INSERT INTO users_backup
SELECT * FROM users WHERE status = 'inactive';

-- With RETURNING
INSERT INTO users (name, email)
VALUES ('John', 'john@example.com')
RETURNING id, name;
```

### UPDATE

```sql
-- Update all
UPDATE users SET status = 'active';

-- Update with WHERE
UPDATE users SET age = 31 WHERE name = 'John';

-- Multiple columns
UPDATE users
SET age = 31, status = 'active'
WHERE id = 1;

-- From another table
UPDATE users
SET status = 'admin'
WHERE id IN (SELECT user_id FROM admins);

-- With RETURNING
UPDATE users
SET age = 31
WHERE id = 1
RETURNING id, name, age;
```

### DELETE

```sql
-- Delete with condition
DELETE FROM users WHERE id = 1;

-- Delete all (dangerous!)
DELETE FROM users;

-- With RETURNING
DELETE FROM users
WHERE status = 'inactive'
RETURNING id, name;
```

### UPSERT

```sql
-- Insert or update
INSERT INTO users (id, name, email)
VALUES (1, 'John', 'john@example.com')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  email = EXCLUDED.email;

-- On conflict update all
INSERT INTO users (id, name, email)
VALUES (1, 'John', 'john@example.com')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name;

-- On conflict do nothing
INSERT INTO users (id, name, email)
VALUES (1, 'John', 'john@example.com')
ON CONFLICT (id) DO NOTHING;
```

## Aggregation

### Aggregate Functions

```sql
-- Count
SELECT COUNT(*) FROM users;
SELECT COUNT(email) FROM users;       -- Counts non-NULL values
SELECT COUNT(DISTINCT status) FROM users;

-- Sum
SELECT SUM(salary) FROM employees;

-- Average
SELECT AVG(age) FROM users;

-- Min/Max
SELECT MIN(age), MAX(age) FROM users;

-- String concatenation
SELECT STRING_AGG(name, ', ') FROM users;
```

### Window Functions

```sql
-- Row number
SELECT id, name, ROW_NUMBER() OVER (ORDER BY age) as row_num FROM users;

-- Rank
SELECT id, salary, RANK() OVER (ORDER BY salary DESC) as rank FROM employees;

-- Lead/Lag
SELECT
  name,
  salary,
  LAG(salary) OVER (ORDER BY salary) as prev_salary,
  LEAD(salary) OVER (ORDER BY salary) as next_salary
FROM employees;

-- Cumulative sum
SELECT
  name,
  salary,
  SUM(salary) OVER (ORDER BY hire_date) as cumulative_salary
FROM employees;
```

## Indexes

Create indexes for faster queries.

```sql
-- Create index
CREATE INDEX idx_users_email ON users(email);

-- Unique index
CREATE UNIQUE INDEX idx_users_username ON users(username);

-- Composite index
CREATE INDEX idx_posts_user_created ON posts(user_id, created_at DESC);

-- Partial index
CREATE INDEX idx_active_users ON users(email) WHERE status = 'active';

-- Full-text search
CREATE INDEX idx_posts_search ON posts USING GIN(to_tsvector('english', content));

-- Drop index
DROP INDEX idx_users_email;

-- List indexes
\di
SELECT indexname FROM pg_indexes WHERE tablename = 'users';
```

## Views

Create virtual tables.

```sql
-- Create view
CREATE VIEW active_users AS
SELECT id, name, email FROM users WHERE status = 'active';

-- Query view
SELECT * FROM active_users;

-- Create or replace
CREATE OR REPLACE VIEW active_users AS
SELECT id, name, email FROM users WHERE status = 'active';

-- Drop view
DROP VIEW active_users;
DROP VIEW IF EXISTS active_users CASCADE;
```

## Transactions

```sql
-- Begin transaction
BEGIN;
  INSERT INTO users VALUES (...);
  UPDATE posts SET status = 'published';
COMMIT;

-- Rollback
BEGIN;
  DELETE FROM users WHERE id = 1;
ROLLBACK;

-- Savepoint
BEGIN;
  INSERT INTO users VALUES (...);
  SAVEPOINT sp1;
  DELETE FROM posts WHERE id = 1;
  ROLLBACK TO sp1;
COMMIT;
```

## Users & Permissions

```sql
-- Create user
CREATE USER myuser WITH PASSWORD 'password';
CREATE ROLE myuser WITH LOGIN PASSWORD 'password';

-- Grant permissions
GRANT CONNECT ON DATABASE mydb TO myuser;
GRANT USAGE ON SCHEMA public TO myuser;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO myuser;
GRANT INSERT, UPDATE, DELETE ON users TO myuser;

-- Revoke permissions
REVOKE SELECT ON users FROM myuser;

-- Alter user
ALTER USER myuser WITH PASSWORD 'newpassword';

-- Drop user
DROP USER myuser;

-- List users
\du
SELECT * FROM pg_user;
```

## Common Operations

```bash
# Connect as different user
psql -U myuser -d mydb

# Show current user
\du

# Show current database
\c

# Switch database
\c other_database

# List tables
\dt
\d

# Show table structure
\d users

# Show indexes
\di

# Exit psql
\q
```
