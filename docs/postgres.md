*postgres.txt*  PostgreSQL Reference

==============================================================================
CONTENTS                                                    *postgres-contents*

1. Installation .......................... |postgres-install|
2. Connection ............................ |postgres-connection|
3. Database Management ................... |postgres-database|
4. Tables ................................ |postgres-tables|
5. Queries ............................... |postgres-queries|
6. Data Manipulation ..................... |postgres-data|
7. Aggregation ........................... |postgres-aggregation|
8. Indexes ............................... |postgres-indexes|
9. Views ................................. |postgres-views|
10. Transactions ......................... |postgres-transactions|
11. Users & Permissions .................. |postgres-users|
12. Common Operations .................... |postgres-operations|

==============================================================================
1. INSTALLATION                                            *postgres-install*

Install PostgreSQL~
>
    # macOS (Homebrew)
    brew install postgresql@15
    brew services start postgresql@15

    # Ubuntu/Debian
    sudo apt-get install postgresql postgresql-contrib
    sudo systemctl start postgresql
    sudo systemctl enable postgresql

    # Docker
    docker run --name postgres -e POSTGRES_PASSWORD=secret \
      -p 5432:5432 -d postgres:15
<

==============================================================================
2. CONNECTION                                           *postgres-connection*

psql~                                                       *postgres-psql*
>
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
<

Connection string~                                 *postgres-connection-string*
>
    postgresql://user:password@localhost:5432/dbname

    # Components
    postgresql://          # Protocol
    user:password         # Credentials
    localhost            # Host
    5432                # Port (optional, default)
    /dbname              # Database name
<

Environment variable~
>
    export DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
    psql $DATABASE_URL
<

==============================================================================
3. DATABASE MANAGEMENT                                    *postgres-database*

Create database~                                    *postgres-database-create*
>
    CREATE DATABASE mydb;
    CREATE DATABASE mydb OWNER myuser;
    CREATE DATABASE mydb ENCODING 'UTF8' LOCALE 'en_US.UTF-8';

    -- With connection limit
    CREATE DATABASE mydb WITH CONNECTION LIMIT 100;
<

List databases~                                       *postgres-database-list*
>
    # In psql
    \l
    \list

    # Via SQL
    SELECT datname FROM pg_database WHERE datistemplate = false;
<

Drop database~                                        *postgres-database-drop*
>
    DROP DATABASE mydb;
    DROP DATABASE IF EXISTS mydb;

    -- Force drop (terminate connections)
    SELECT pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'mydb';

    DROP DATABASE mydb;
<

Backup & Restore~                                  *postgres-database-backup*
>
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
<

==============================================================================
4. TABLES                                                   *postgres-tables*

Create table~                                       *postgres-tables-create*
>
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
<

Data types~                                           *postgres-data-types*
>
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
<

Constraints~                                       *postgres-constraints*
>
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
<

Alter table~                                         *postgres-alter-table*
>
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
<

Drop table~                                           *postgres-drop-table*
>
    DROP TABLE users;
    DROP TABLE IF EXISTS users;

    -- Cascade (drop dependent objects)
    DROP TABLE users CASCADE;
<

==============================================================================
5. QUERIES                                                 *postgres-queries*

SELECT~                                                  *postgres-select*
>
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
<

WHERE~                                                    *postgres-where*
>
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
<

JOIN~                                                      *postgres-join*
>
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
<

GROUP BY~                                                *postgres-group-by*
>
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
<

ORDER BY~                                                *postgres-order-by*
>
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
<

LIMIT & OFFSET~                                          *postgres-limit*
>
    -- Limit
    SELECT * FROM users LIMIT 10;

    -- Offset
    SELECT * FROM users LIMIT 10 OFFSET 20;

    -- Pagination
    SELECT * FROM users ORDER BY id LIMIT 10 OFFSET (page - 1) * 10;

    -- Shorthand
    SELECT * FROM users LIMIT 10 OFFSET 20;
    SELECT * FROM users OFFSET 20 LIMIT 10;  -- Same
<

==============================================================================
6. DATA MANIPULATION                                          *postgres-data*

INSERT~                                                  *postgres-insert*
>
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
<

UPDATE~                                                  *postgres-update*
>
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
<

DELETE~                                                  *postgres-delete*
>
    -- Delete with condition
    DELETE FROM users WHERE id = 1;

    -- Delete all (dangerous!)
    DELETE FROM users;

    -- With RETURNING
    DELETE FROM users
    WHERE status = 'inactive'
    RETURNING id, name;
<

UPSERT~                                                  *postgres-upsert*
>
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
<

==============================================================================
7. AGGREGATION                                        *postgres-aggregation*

Aggregate functions~                              *postgres-aggregate-functions*
>
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
<

Window functions~                                  *postgres-window-functions*
>
    -- Row number
    SELECT id, name, ROW_NUMBER() OVER (ORDER BY age) as row_num FROM users;

    -- Rank
    SELECT id, salary, RANK() OVER (ORDER BY salary DESC) as rank
    FROM employees;

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
<

==============================================================================
8. INDEXES                                                *postgres-indexes*

Create index~                                         *postgres-create-index*
>
    -- Create index
    CREATE INDEX idx_users_email ON users(email);

    -- Unique index
    CREATE UNIQUE INDEX idx_users_username ON users(username);

    -- Composite index
    CREATE INDEX idx_posts_user_created ON posts(user_id, created_at DESC);

    -- Partial index
    CREATE INDEX idx_active_users ON users(email) WHERE status = 'active';

    -- Full-text search
    CREATE INDEX idx_posts_search
      ON posts USING GIN(to_tsvector('english', content));

    -- Drop index
    DROP INDEX idx_users_email;

    -- List indexes
    \di
    SELECT indexname FROM pg_indexes WHERE tablename = 'users';
<

==============================================================================
9. VIEWS                                                    *postgres-views*

Create view~                                           *postgres-create-view*
>
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
<

==============================================================================
10. TRANSACTIONS                                      *postgres-transactions*

Transaction commands~                              *postgres-transaction-commands*
>
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
<

==============================================================================
11. USERS & PERMISSIONS                                     *postgres-users*

User management~                                        *postgres-user-management*
>
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
<

==============================================================================
12. COMMON OPERATIONS                                  *postgres-operations*

Common commands~                                     *postgres-common-commands*
>
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
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
