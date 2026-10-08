-- ============================================================
-- B5 - Using the functions inside SQL
-- Take the screenshot of the first query for B5_select_output.png
-- ============================================================
SET LINESIZE 200
SET PAGESIZE 50
COLUMN employee      FORMAT A22
COLUMN department    FORMAT A24
COLUMN annual_salary FORMAT 999,999,999
COLUMN monthly_tax   FORMAT 999,999,999

-- 1) Functions in the SELECT list
SELECT e.emp_id,
       e.first_name || ' ' || e.last_name  AS employee,
       fn_dept_name(e.dept_id)             AS department,
       e.salary,
       fn_annual_salary(e.emp_id)          AS annual_salary,
       fn_years_of_service(e.emp_id)       AS years_service,
       fn_calculate_tax(e.salary)          AS monthly_tax
  FROM employees e
 ORDER BY e.emp_id;

-- 2) Function in WHERE
SELECT emp_id, first_name, fn_years_of_service(emp_id) AS years_service
  FROM employees
 WHERE fn_years_of_service(emp_id) >= 5;

-- 3) Function in ORDER BY
SELECT emp_id, first_name, fn_annual_salary(emp_id) AS annual_salary
  FROM employees
 ORDER BY fn_annual_salary(emp_id) DESC;
