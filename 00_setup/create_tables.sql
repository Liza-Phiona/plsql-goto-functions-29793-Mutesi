-- ============================================================
-- 00_setup/create_tables.sql
-- Creates DEPARTMENTS and EMPLOYEES tables with sample data.
-- Salaries are MONTHLY, in RWF.
-- ============================================================
SET SERVEROUTPUT ON

-- Safe drops (ignore ORA-00942: table does not exist)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN
  IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN
  IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

CREATE TABLE departments (
  dept_id    NUMBER(4)     PRIMARY KEY,
  dept_name  VARCHAR2(50)  NOT NULL
);

CREATE TABLE employees (
  emp_id      NUMBER(6)     PRIMARY KEY,
  first_name  VARCHAR2(30)  NOT NULL,
  last_name   VARCHAR2(30)  NOT NULL,
  dept_id     NUMBER(4)     REFERENCES departments(dept_id),
  salary      NUMBER(12,2),            -- monthly gross salary
  bonus       NUMBER(12,2),            -- yearly bonus (may be NULL)
  hire_date   DATE          NOT NULL
);

INSERT INTO departments VALUES (10, 'Finance');
INSERT INTO departments VALUES (20, 'Information Technology');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Marketing');

INSERT INTO employees VALUES (101, 'Alice',   'Uwase',     10,  850000, 100000, DATE '2015-03-15');
INSERT INTO employees VALUES (102, 'Brian',   'Mugisha',   20,  450000,  50000, DATE '2018-07-01');
INSERT INTO employees VALUES (103, 'Claire',  'Ingabire',  20,  250000,   NULL, DATE '2021-01-10');
INSERT INTO employees VALUES (104, 'David',   'Niyonzima', 30,  120000,   NULL, DATE '2023-09-05');
INSERT INTO employees VALUES (105, 'Esther',  'Mukamana',  40,   55000,   NULL, DATE '2024-05-20');
INSERT INTO employees VALUES (106, 'Frank',   'Habimana',  10,  620000,  80000, DATE '2012-11-30');
INSERT INTO employees VALUES (107, 'Grace',   'Uwimana',   30,  350000,  20000, DATE '2019-02-14');

COMMIT;

SELECT * FROM departments ORDER BY dept_id;
SELECT * FROM employees ORDER BY emp_id;
