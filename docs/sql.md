*sql.txt*  SQL Reference

==============================================================================
CONTENTS                                                         *sql-contents*

1. Basic Queries ......................... |sql-queries|
2. Filtering ............................. |sql-filtering|
3. Sorting ............................... |sql-sorting|
4. Aggregation ........................... |sql-aggregation|
5. JOIN Types ............................ |sql-joins|
6. Subqueries ............................ |sql-subqueries|
7. Common Table Expressions (CTE) ........ |sql-cte|
8. Window Functions ...................... |sql-window|
9. CASE Expressions ...................... |sql-case|
10. Data Modification .................... |sql-modification|
11. Table Operations ..................... |sql-tables|
12. Indexes .............................. |sql-indexes|
13. Constraints .......................... |sql-constraints|
14. Transactions ......................... |sql-transactions|
15. Views ................................ |sql-views|
16. String Functions ..................... |sql-strings|
17. Date Functions ....................... |sql-dates|
18. NULL Handling ........................ |sql-null|
19. Set Operations ....................... |sql-sets|
20. Performance Tips ..................... |sql-performance|

==============================================================================
1. BASIC QUERIES                                               *sql-queries*

Select statements~                                      *sql-queries-select*
>
    -- Select all columns
    SELECT * FROM users;

    -- Select specific columns
    SELECT id, name, email FROM users;

    -- Limit results
    SELECT * FROM users LIMIT 10;
    SELECT * FROM users LIMIT 10 OFFSET 20;

    -- Distinct values
    SELECT DISTINCT country FROM users;

    -- Column aliases
    SELECT
      first_name AS fname,
      last_name AS lname,
      CONCAT(first_name, ' ', last_name) AS full_name
    FROM users;

    -- Table aliases
    SELECT u.name, o.total
    FROM users u
    JOIN orders o ON u.id = o.user_id;
<

==============================================================================
2. FILTERING                                                 *sql-filtering*

WHERE clause~                                         *sql-filtering-where*
>
    -- Basic WHERE
    SELECT * FROM users WHERE age > 18;
    SELECT * FROM users WHERE country = 'USA';
    SELECT * FROM users WHERE email IS NOT NULL;
<

Comparison operators~                            *sql-filtering-comparison*
>
    WHERE age = 25
    WHERE age != 25
    WHERE age <> 25      -- Same as !=
    WHERE age > 25
    WHERE age < 25
    WHERE age >= 25
    WHERE age <= 25
<

Logical operators~                                *sql-filtering-logical*
>
    WHERE age > 18 AND country = 'USA'
    WHERE age < 18 OR age > 65
    WHERE NOT deleted
<

IN operator~                                            *sql-filtering-in*
>
    WHERE country IN ('USA', 'UK', 'Canada')
    WHERE id IN (1, 2, 3, 4, 5)
<

BETWEEN~                                            *sql-filtering-between*
>
    WHERE age BETWEEN 18 AND 65
    WHERE created_at BETWEEN '2024-01-01' AND '2024-12-31'
<

LIKE pattern matching~                               *sql-filtering-like*
>
    WHERE name LIKE 'John%'         -- Starts with John
    WHERE name LIKE '%Smith'        -- Ends with Smith
    WHERE name LIKE '%John%'        -- Contains John
    WHERE email LIKE '%@gmail.com'
    WHERE code LIKE 'A_B'           -- Underscore = single char

    -- ILIKE (case-insensitive, Postgres)
    WHERE name ILIKE 'john%'
<

IS NULL~                                            *sql-filtering-null*
>
    WHERE email IS NULL
    WHERE deleted_at IS NOT NULL
<

==============================================================================
3. SORTING                                                     *sql-sorting*

ORDER BY~                                                *sql-sorting-order*
>
    SELECT * FROM users ORDER BY name;
    SELECT * FROM users ORDER BY name ASC;
    SELECT * FROM users ORDER BY name DESC;

    -- Multiple columns
    SELECT * FROM users
    ORDER BY country ASC, age DESC;

    -- By column position
    SELECT name, age FROM users ORDER BY 2 DESC;

    -- NULL ordering
    ORDER BY email NULLS FIRST
    ORDER BY email NULLS LAST
<

==============================================================================
4. AGGREGATION                                             *sql-aggregation*

Aggregate functions~                             *sql-aggregation-functions*
>
    SELECT COUNT(*) FROM users;
    SELECT COUNT(DISTINCT country) FROM users;
    SELECT SUM(total) FROM orders;
    SELECT AVG(age) FROM users;
    SELECT MIN(age) FROM users;
    SELECT MAX(age) FROM users;
<

GROUP BY~                                             *sql-aggregation-group*
>
    SELECT country, COUNT(*)
    FROM users
    GROUP BY country;

    SELECT country, AVG(age) AS avg_age
    FROM users
    GROUP BY country
    ORDER BY avg_age DESC;

    -- Multiple grouping columns
    SELECT country, city, COUNT(*)
    FROM users
    GROUP BY country, city;
<

HAVING~                                              *sql-aggregation-having*
>
    -- Filter after grouping
    SELECT country, COUNT(*) AS user_count
    FROM users
    GROUP BY country
    HAVING COUNT(*) > 100;

    SELECT category, AVG(price) AS avg_price
    FROM products
    GROUP BY category
    HAVING AVG(price) > 50;
<

==============================================================================
5. JOIN TYPES                                                    *sql-joins*

INNER JOIN~                                              *sql-joins-inner*
>
    -- Only matching rows
    SELECT u.name, o.total
    FROM users u
    INNER JOIN orders o ON u.id = o.user_id;
<

LEFT JOIN~                                                *sql-joins-left*
>
    -- All from left, matching from right
    SELECT u.name, o.total
    FROM users u
    LEFT JOIN orders o ON u.id = o.user_id;
<

RIGHT JOIN~                                              *sql-joins-right*
>
    -- All from right, matching from left
    SELECT u.name, o.total
    FROM users u
    RIGHT JOIN orders o ON u.id = o.user_id;
<

FULL OUTER JOIN~                                          *sql-joins-full*
>
    -- All from both
    SELECT u.name, o.total
    FROM users u
    FULL OUTER JOIN orders o ON u.id = o.user_id;
<

CROSS JOIN~                                              *sql-joins-cross*
>
    -- Cartesian product
    SELECT u.name, p.name
    FROM users u
    CROSS JOIN products p;
<

Self join~                                                *sql-joins-self*
>
    SELECT
      e1.name AS employee,
      e2.name AS manager
    FROM employees e1
    LEFT JOIN employees e2 ON e1.manager_id = e2.id;
<

Multiple joins~                                        *sql-joins-multiple*
>
    SELECT
      u.name,
      o.order_date,
      p.name AS product_name
    FROM users u
    JOIN orders o ON u.id = o.user_id
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id;

    -- Join with conditions
    SELECT u.name, o.total
    FROM users u
    LEFT JOIN orders o
      ON u.id = o.user_id
      AND o.status = 'completed';
<

==============================================================================
6. SUBQUERIES                                                *sql-subqueries*

Subquery in WHERE~                                 *sql-subqueries-where*
>
    SELECT name FROM users
    WHERE id IN (
      SELECT user_id FROM orders WHERE total > 1000
    );
<

Subquery in FROM~                                   *sql-subqueries-from*
>
    -- Derived table
    SELECT avg_age
    FROM (
      SELECT AVG(age) AS avg_age
      FROM users
      GROUP BY country
    ) AS country_averages;
<

Subquery in SELECT~                               *sql-subqueries-select*
>
    SELECT
      name,
      (SELECT COUNT(*) FROM orders WHERE user_id = users.id) AS order_count
    FROM users;
<

Correlated subquery~                          *sql-subqueries-correlated*
>
    SELECT name
    FROM users u
    WHERE age > (
      SELECT AVG(age)
      FROM users
      WHERE country = u.country
    );
<

EXISTS~                                              *sql-subqueries-exists*
>
    SELECT name FROM users u
    WHERE EXISTS (
      SELECT 1 FROM orders WHERE user_id = u.id
    );

    -- NOT EXISTS
    SELECT name FROM users u
    WHERE NOT EXISTS (
      SELECT 1 FROM orders WHERE user_id = u.id
    );
<

==============================================================================
7. COMMON TABLE EXPRESSIONS (CTE)                                 *sql-cte*

Basic CTE~                                                  *sql-cte-basic*
>
    WITH high_value_orders AS (
      SELECT * FROM orders WHERE total > 1000
    )
    SELECT u.name, o.total
    FROM users u
    JOIN high_value_orders o ON u.id = o.user_id;
<

Multiple CTEs~                                           *sql-cte-multiple*
>
    WITH
      active_users AS (
        SELECT * FROM users WHERE last_login > NOW() - INTERVAL '30 days'
      ),
      recent_orders AS (
        SELECT * FROM orders WHERE created_at > NOW() - INTERVAL '7 days'
      )
    SELECT u.name, COUNT(o.id) AS order_count
    FROM active_users u
    LEFT JOIN recent_orders o ON u.id = o.user_id
    GROUP BY u.name;
<

Recursive CTE~                                         *sql-cte-recursive*
>
    -- Hierarchical data
    WITH RECURSIVE employee_hierarchy AS (
      -- Base case
      SELECT id, name, manager_id, 1 AS level
      FROM employees
      WHERE manager_id IS NULL

      UNION ALL

      -- Recursive case
      SELECT e.id, e.name, e.manager_id, eh.level + 1
      FROM employees e
      JOIN employee_hierarchy eh ON e.manager_id = eh.id
    )
    SELECT * FROM employee_hierarchy;
<

==============================================================================
8. WINDOW FUNCTIONS                                             *sql-window*

ROW_NUMBER~                                            *sql-window-row-number*
>
    -- Unique sequential number
    SELECT
      name,
      age,
      ROW_NUMBER() OVER (ORDER BY age DESC) AS row_num
    FROM users;
<

RANK~                                                       *sql-window-rank*
>
    -- Same rank for ties, gaps after
    SELECT
      name,
      score,
      RANK() OVER (ORDER BY score DESC) AS rank
    FROM students;
<

DENSE_RANK~                                           *sql-window-dense-rank*
>
    -- Same rank for ties, no gaps
    SELECT
      name,
      score,
      DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rank
    FROM students;
<

PARTITION BY~                                         *sql-window-partition*
>
    SELECT
      name,
      country,
      age,
      ROW_NUMBER() OVER (
        PARTITION BY country ORDER BY age DESC
      ) AS rank_in_country
    FROM users;
<

LAG and LEAD~                                          *sql-window-lag-lead*
>
    -- LAG: previous row value
    SELECT
      date,
      revenue,
      LAG(revenue) OVER (ORDER BY date) AS prev_revenue,
      revenue - LAG(revenue) OVER (ORDER BY date) AS diff
    FROM daily_sales;

    -- LEAD: next row value
    SELECT
      date,
      revenue,
      LEAD(revenue) OVER (ORDER BY date) AS next_revenue
    FROM daily_sales;
<

FIRST_VALUE and LAST_VALUE~                         *sql-window-first-last*
>
    SELECT
      name,
      salary,
      FIRST_VALUE(salary) OVER (ORDER BY salary) AS lowest_salary,
      LAST_VALUE(salary) OVER (
        ORDER BY salary
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) AS highest_salary
    FROM employees;
<

Running total~                                          *sql-window-running*
>
    -- SUM() OVER
    SELECT
      date,
      amount,
      SUM(amount) OVER (ORDER BY date) AS running_total
    FROM transactions;
<

Moving average~                                         *sql-window-moving*
>
    SELECT
      date,
      price,
      AVG(price) OVER (
        ORDER BY date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
      ) AS moving_avg_7_days
    FROM stock_prices;
<

NTILE~                                                     *sql-window-ntile*
>
    -- Divide into N groups
    SELECT
      name,
      salary,
      NTILE(4) OVER (ORDER BY salary) AS quartile
    FROM employees;
<

==============================================================================
9. CASE EXPRESSIONS                                               *sql-case*

Simple CASE~                                              *sql-case-simple*
>
    SELECT
      name,
      CASE grade
        WHEN 'A' THEN 'Excellent'
        WHEN 'B' THEN 'Good'
        WHEN 'C' THEN 'Average'
        ELSE 'Needs Improvement'
      END AS performance
    FROM students;
<

Searched CASE~                                          *sql-case-searched*
>
    SELECT
      name,
      age,
      CASE
        WHEN age < 18 THEN 'Minor'
        WHEN age BETWEEN 18 AND 64 THEN 'Adult'
        ELSE 'Senior'
      END AS age_group
    FROM users;
<

CASE in aggregation~                               *sql-case-aggregation*
>
    SELECT
      country,
      COUNT(*) AS total_users,
      COUNT(CASE WHEN age < 18 THEN 1 END) AS minors,
      COUNT(CASE WHEN age >= 18 THEN 1 END) AS adults
    FROM users
    GROUP BY country;
<

CASE in ORDER BY~                                    *sql-case-order-by*
>
    SELECT name, status
    FROM orders
    ORDER BY
      CASE status
        WHEN 'urgent' THEN 1
        WHEN 'high' THEN 2
        WHEN 'normal' THEN 3
        ELSE 4
      END;
<

==============================================================================
10. DATA MODIFICATION                                     *sql-modification*

INSERT~                                             *sql-modification-insert*
>
    -- Single row
    INSERT INTO users (name, email, age)
    VALUES ('John Doe', 'john@example.com', 30);

    -- Multiple rows
    INSERT INTO users (name, email, age)
    VALUES
      ('Alice', 'alice@example.com', 25),
      ('Bob', 'bob@example.com', 35);

    -- From SELECT
    INSERT INTO archived_users
    SELECT * FROM users WHERE last_login < '2020-01-01';

    -- INSERT ... ON CONFLICT (Postgres)
    INSERT INTO users (id, name, email)
    VALUES (1, 'John', 'john@example.com')
    ON CONFLICT (id)
    DO UPDATE SET name = EXCLUDED.name, email = EXCLUDED.email;
<

UPDATE~                                             *sql-modification-update*
>
    UPDATE users
    SET age = 31, updated_at = NOW()
    WHERE id = 1;

    -- UPDATE with JOIN
    UPDATE users u
    SET status = 'active'
    FROM orders o
    WHERE u.id = o.user_id
      AND o.created_at > NOW() - INTERVAL '30 days';

    -- UPDATE with CASE
    UPDATE products
    SET price = CASE
      WHEN category = 'electronics' THEN price * 1.1
      WHEN category = 'books' THEN price * 1.05
      ELSE price
    END;
<

DELETE~                                             *sql-modification-delete*
>
    DELETE FROM users WHERE id = 1;

    -- DELETE with JOIN
    DELETE FROM orders
    WHERE user_id IN (
      SELECT id FROM users WHERE deleted = true
    );

    -- TRUNCATE (faster, resets auto-increment)
    TRUNCATE TABLE temp_data;
<

==============================================================================
11. TABLE OPERATIONS                                            *sql-tables*

CREATE TABLE~                                         *sql-tables-create*
>
    CREATE TABLE users (
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      email VARCHAR(255) UNIQUE NOT NULL,
      age INTEGER CHECK (age >= 0),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- CREATE TABLE from SELECT
    CREATE TABLE active_users AS
    SELECT * FROM users WHERE last_login > NOW() - INTERVAL '30 days';
<

ALTER TABLE~                                           *sql-tables-alter*
>
    ALTER TABLE users ADD COLUMN phone VARCHAR(20);
    ALTER TABLE users DROP COLUMN phone;
    ALTER TABLE users ALTER COLUMN name TYPE TEXT;
    ALTER TABLE users RENAME COLUMN name TO full_name;
    ALTER TABLE users RENAME TO customers;
<

DROP TABLE~                                             *sql-tables-drop*
>
    DROP TABLE users;
    DROP TABLE IF EXISTS users;
<

TEMPORARY TABLE~                                        *sql-tables-temp*
>
    CREATE TEMP TABLE temp_data (
      id INTEGER,
      value TEXT
    );
<

==============================================================================
12. INDEXES                                                    *sql-indexes*

Create index~                                         *sql-indexes-create*
>
    -- Basic index
    CREATE INDEX idx_users_email ON users(email);
    CREATE INDEX idx_users_country_age ON users(country, age);

    -- Unique index
    CREATE UNIQUE INDEX idx_users_email_unique ON users(email);

    -- Partial index
    CREATE INDEX idx_active_users ON users(email)
    WHERE deleted_at IS NULL;

    -- Expression index
    CREATE INDEX idx_users_lower_email ON users(LOWER(email));
<

Drop index~                                             *sql-indexes-drop*
>
    DROP INDEX idx_users_email;

    -- List indexes
    \di                      -- Postgres
    SHOW INDEX FROM users;   -- MySQL
<

==============================================================================
13. CONSTRAINTS                                             *sql-constraints*

PRIMARY KEY~                                       *sql-constraints-primary*
>
    CREATE TABLE users (
      id INTEGER PRIMARY KEY
    );
<

FOREIGN KEY~                                       *sql-constraints-foreign*
>
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY,
      user_id INTEGER REFERENCES users(id)
    );

    -- With actions
    CREATE TABLE orders (
      id INTEGER PRIMARY KEY,
      user_id INTEGER REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );
<

UNIQUE~                                             *sql-constraints-unique*
>
    CREATE TABLE users (
      email VARCHAR(255) UNIQUE
    );
<

CHECK~                                               *sql-constraints-check*
>
    CREATE TABLE products (
      price DECIMAL CHECK (price >= 0)
    );
<

NOT NULL~                                         *sql-constraints-not-null*
>
    CREATE TABLE users (
      name VARCHAR(100) NOT NULL
    );
<

Add/Drop constraints~                              *sql-constraints-alter*
>
    -- Add constraint
    ALTER TABLE users ADD CONSTRAINT chk_age CHECK (age >= 0);
    ALTER TABLE orders ADD FOREIGN KEY (user_id) REFERENCES users(id);

    -- Drop constraint
    ALTER TABLE users DROP CONSTRAINT chk_age;
<

==============================================================================
14. TRANSACTIONS                                          *sql-transactions*

Basic transaction~                               *sql-transactions-basic*
>
    BEGIN;
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE id = 2;
    COMMIT;

    -- Rollback on error
    BEGIN;
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    -- Error occurs
    ROLLBACK;
<

Savepoints~                                     *sql-transactions-savepoints*
>
    BEGIN;
    UPDATE users SET status = 'active' WHERE id = 1;
    SAVEPOINT sp1;
    UPDATE users SET status = 'inactive' WHERE id = 2;
    ROLLBACK TO SAVEPOINT sp1;
    COMMIT;
<

Isolation levels~                              *sql-transactions-isolation*
>
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
<

==============================================================================
15. VIEWS                                                        *sql-views*

Create view~                                            *sql-views-create*
>
    CREATE VIEW active_users AS
    SELECT id, name, email
    FROM users
    WHERE deleted_at IS NULL;

    -- Use view
    SELECT * FROM active_users;
<

Materialized view~                                *sql-views-materialized*
>
    -- Postgres
    CREATE MATERIALIZED VIEW user_stats AS
    SELECT
      country,
      COUNT(*) AS user_count,
      AVG(age) AS avg_age
    FROM users
    GROUP BY country;

    -- Refresh materialized view
    REFRESH MATERIALIZED VIEW user_stats;
<

Drop view~                                                *sql-views-drop*
>
    DROP VIEW active_users;
    DROP MATERIALIZED VIEW user_stats;
<

==============================================================================
16. STRING FUNCTIONS                                           *sql-strings*

Concatenation~                                       *sql-strings-concat*
>
    SELECT CONCAT(first_name, ' ', last_name) AS full_name;
    SELECT first_name || ' ' || last_name AS full_name;  -- Postgres
<

Case conversion~                                      *sql-strings-case*
>
    SELECT UPPER(name), LOWER(email);
<

Substring~                                          *sql-strings-substring*
>
    SELECT SUBSTRING(name, 1, 3);  -- First 3 characters
    SELECT LEFT(name, 3);          -- First 3 characters
    SELECT RIGHT(name, 3);         -- Last 3 characters
<

Length and trim~                                      *sql-strings-length*
>
    -- Length
    SELECT LENGTH(name);
    SELECT CHAR_LENGTH(name);

    -- Trim
    SELECT TRIM(name);
    SELECT LTRIM(name);
    SELECT RTRIM(name);
<

Replace and pattern matching~                        *sql-strings-replace*
>
    -- Replace
    SELECT REPLACE(email, '@', '[at]');

    -- Pattern matching
    SELECT name FROM users WHERE name LIKE '%John%';
    SELECT name FROM users WHERE name ~ 'John';  -- Regex (Postgres)

    -- Split (Postgres)
    SELECT SPLIT_PART(email, '@', 2) AS domain;
<

==============================================================================
17. DATE FUNCTIONS                                               *sql-dates*

Current date/time~                                      *sql-dates-current*
>
    SELECT NOW();
    SELECT CURRENT_DATE;
    SELECT CURRENT_TIME;
    SELECT CURRENT_TIMESTAMP;
<

Extract parts~                                          *sql-dates-extract*
>
    SELECT EXTRACT(YEAR FROM created_at);
    SELECT EXTRACT(MONTH FROM created_at);
    SELECT EXTRACT(DAY FROM created_at);
    SELECT DATE_PART('year', created_at);  -- Postgres
<

Date arithmetic~                                     *sql-dates-arithmetic*
>
    SELECT NOW() + INTERVAL '1 day';
    SELECT NOW() - INTERVAL '7 days';
    SELECT NOW() + INTERVAL '1 month';
    SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);  -- MySQL
<

Date formatting~                                        *sql-dates-format*
>
    SELECT TO_CHAR(created_at, 'YYYY-MM-DD');    -- Postgres
    SELECT DATE_FORMAT(created_at, '%Y-%m-%d');  -- MySQL
<

Age / difference~                                          *sql-dates-age*
>
    SELECT AGE(NOW(), birth_date);         -- Postgres
    SELECT DATEDIFF(NOW(), birth_date);    -- MySQL

    -- Truncate to date
    SELECT DATE(created_at);
    SELECT DATE_TRUNC('day', created_at);  -- Postgres
<

==============================================================================
18. NULL HANDLING                                                 *sql-null*

Check for NULL~                                          *sql-null-check*
>
    WHERE column IS NULL
    WHERE column IS NOT NULL
<

COALESCE~                                              *sql-null-coalesce*
>
    -- Return first non-NULL
    SELECT COALESCE(phone, email, 'No contact') AS contact;
<

NULLIF~                                                  *sql-null-nullif*
>
    -- Return NULL if values equal
    SELECT NULLIF(column, 0);  -- Returns NULL if column is 0
<

NULL in comparisons~                                *sql-null-comparisons*
>
    NULL = NULL         -- NULL (not TRUE)
    NULL != NULL        -- NULL (not TRUE)
    NULL IS NULL        -- TRUE

    -- NULL in aggregates (ignored)
    SELECT AVG(age) FROM users;  -- NULLs are ignored

    -- NULL in ORDER BY
    ORDER BY name NULLS FIRST
    ORDER BY name NULLS LAST
<

==============================================================================
19. SET OPERATIONS                                                *sql-sets*

UNION~                                                      *sql-sets-union*
>
    -- UNION (distinct)
    SELECT name FROM customers
    UNION
    SELECT name FROM suppliers;

    -- UNION ALL (includes duplicates)
    SELECT name FROM customers
    UNION ALL
    SELECT name FROM suppliers;
<

INTERSECT~                                            *sql-sets-intersect*
>
    -- Common rows
    SELECT name FROM customers
    INTERSECT
    SELECT name FROM suppliers;
<

EXCEPT~                                                  *sql-sets-except*
>
    -- In first but not second
    SELECT name FROM customers
    EXCEPT
    SELECT name FROM suppliers;
<

==============================================================================
20. PERFORMANCE TIPS                                        *sql-performance*

Performance tips~                                  *sql-performance-tips*
>
    -- Use indexes on WHERE, JOIN, ORDER BY columns
    CREATE INDEX idx_users_email ON users(email);

    -- Use EXPLAIN to analyze queries
    EXPLAIN SELECT * FROM users WHERE email = 'test@example.com';
    EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'test@example.com';

    -- Avoid SELECT *
    SELECT id, name, email FROM users;  -- Better

    -- Use LIMIT for large result sets
    SELECT * FROM users LIMIT 100;

    -- Use EXISTS instead of IN for subqueries (often faster)
    WHERE EXISTS (SELECT 1 FROM orders WHERE user_id = users.id)

    -- Avoid functions on indexed columns
    WHERE LOWER(email) = 'test@example.com'  -- Can't use index
    WHERE email = 'test@example.com'         -- Better

    -- Use covering indexes
    CREATE INDEX idx_users_email_name ON users(email, name);

    -- Batch updates
    UPDATE users SET status = 'active' WHERE id IN (1,2,3,4,5);

    -- Regular VACUUM (Postgres)
    VACUUM ANALYZE users;
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
