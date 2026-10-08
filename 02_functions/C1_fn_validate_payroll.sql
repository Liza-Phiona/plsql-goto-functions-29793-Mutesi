-- ============================================================
-- C1 - fn_validate_payroll(p_emp_id)  (Combined task)
-- Uses: GOTO (single exit point for failures), B3 and B4 functions.
-- Returns 'VALID: ...' or 'INVALID: <reason>'.
-- Run AFTER B1-B4.
-- ============================================================
CREATE OR REPLACE FUNCTION fn_validate_payroll (p_emp_id IN NUMBER)
RETURN VARCHAR2
IS
  v_count  NUMBER;
  v_emp    employees%ROWTYPE;
  v_dept   VARCHAR2(50);
  v_tax    NUMBER;
  v_msg    VARCHAR2(200);
BEGIN
  -- Check 1: employee exists
  SELECT COUNT(*) INTO v_count FROM employees WHERE emp_id = p_emp_id;
  IF v_count = 0 THEN
    v_msg := 'INVALID: employee ' || p_emp_id || ' does not exist';
    GOTO invalid_result;
  END IF;

  SELECT * INTO v_emp FROM employees WHERE emp_id = p_emp_id;

  -- Check 2: salary present and positive
  IF v_emp.salary IS NULL OR v_emp.salary <= 0 THEN
    v_msg := 'INVALID: salary is missing or not positive';
    GOTO invalid_result;
  END IF;

  -- Check 3: department valid
  v_dept := fn_dept_name(v_emp.dept_id);
  IF v_dept = 'Unknown' THEN
    v_msg := 'INVALID: employee has no valid department';
    GOTO invalid_result;
  END IF;

  -- Check 4: hire date not in the future
  IF v_emp.hire_date > SYSDATE THEN
    v_msg := 'INVALID: hire date is in the future';
    GOTO invalid_result;
  END IF;

  -- Check 5: tax must be lower than salary
  v_tax := fn_calculate_tax(v_emp.salary);
  IF v_tax >= v_emp.salary THEN
    v_msg := 'INVALID: tax (' || v_tax || ') is not lower than salary';
    GOTO invalid_result;
  END IF;

  RETURN 'VALID: ' || v_emp.first_name || ' ' || v_emp.last_name ||
         ' | Dept: ' || v_dept ||
         ' | Tax: ' || TO_CHAR(v_tax, 'FM999,999,990') ||
         ' | Net: ' || TO_CHAR(v_emp.salary - v_tax, 'FM999,999,990');

  <<invalid_result>>
  RETURN v_msg;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'INVALID: unexpected error - ' || SQLERRM;
END fn_validate_payroll;
/
SHOW ERRORS FUNCTION fn_validate_payroll
