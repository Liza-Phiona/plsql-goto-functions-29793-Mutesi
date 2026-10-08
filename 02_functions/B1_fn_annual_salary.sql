-- ============================================================
-- B1 - fn_annual_salary(p_emp_id)
-- Annual salary = monthly salary * 12 + yearly bonus (NULL -> 0)
-- Raises -20001 if the employee does not exist.
-- ============================================================
CREATE OR REPLACE FUNCTION fn_annual_salary (p_emp_id IN NUMBER)
RETURN NUMBER
IS
  v_salary employees.salary%TYPE;
  v_bonus  employees.bonus%TYPE;
BEGIN
  SELECT NVL(salary, 0), NVL(bonus, 0)
    INTO v_salary, v_bonus
    FROM employees
   WHERE emp_id = p_emp_id;

  RETURN (v_salary * 12) + v_bonus;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Employee ' || p_emp_id || ' not found');
END fn_annual_salary;
/
SHOW ERRORS FUNCTION fn_annual_salary
