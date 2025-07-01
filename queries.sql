mysql> create database task5;
Query OK, 1 row affected (0.03 sec)
mysql> use task5;
Database changed
mysql> -- Sample dataset for testing
mysql> CREATE TABLE Employees (
    ->     emp_id INTEGER PRIMARY KEY,
    ->     name TEXT,
    ->     department_id INTEGER,
    ->     salary INTEGER
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> CREATE TABLE Departments (
    ->     department_id INTEGER PRIMARY KEY,
    ->     department_name TEXT
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> INSERT INTO Employees VALUES
    -> (1, 'Alice', 101, 60000),
    -> (2, 'Bob', 102, 45000),
    -> (3, 'Charlie', 101, 70000),
    -> (4, 'David', 103, 50000),
    -> (5, 'Eva', 102, 40000);
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Departments VALUES
    -> (101, 'HR'),
    -> (102, 'Sales'),
    -> (103, 'IT');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> -- 1. Scalar Subquery in SELECT
mysql> SELECT name, salary,
    ->        (SELECT AVG(salary) FROM Employees) AS avg_salary
    -> FROM Employees;

mysql> -- 2. Subquery with IN in WHERE
mysql> SELECT name FROM Employees
    -> WHERE department_id IN (
    ->     SELECT department_id FROM Departments
    ->     WHERE department_name = 'Sales'
    -> );

mysql> -- 3. Correlated Subquery
mysql> SELECT name, salary
    -> FROM Employees e
    -> WHERE salary > (
    ->     SELECT AVG(salary)
    ->     FROM Employees
    ->     WHERE department_id = e.department_id
    -> );

mysql> -- 4. EXISTS Clause
mysql> SELECT name
    -> FROM Employees e
    -> WHERE EXISTS (
    ->     SELECT 1
    ->     FROM Departments d
    ->     WHERE d.department_id = e.department_id AND d.department_name = 'IT'
    -> );

mysql> -- 5. Subquery in FROM clause (Derived Table)
mysql> SELECT department_id, avg_salary
    -> FROM (
    ->     SELECT department_id, AVG(salary) AS avg_salary
    ->     FROM Employees
    ->     GROUP BY department_id
    -> ) AS dept_avg
    -> WHERE avg_salary > 50000;