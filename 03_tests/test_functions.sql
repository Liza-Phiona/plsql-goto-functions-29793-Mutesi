-- ============================================================
-- test_functions.sql - tests for B1..B4 including error cases
-- ============================================================
SET SERVEROUTPUT ON

DECLARE
  PROCEDURE show(p_label VARCHAR2, p_value VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD(p_label, 46) || ' => ' || p_value);
  END;
BEGIN
  DBMS_OUTPUT.PUT_LINE('===== B1 fn_annual_salary =====');
  show('Emp 101 (850000*12 + 100000 = 10,300,000)', fn_annual_salary(101));
  show('Emp 103 (250000*12, NULL bonus = 3,000,000)', fn_annual_salary(103));
  BEGIN
    show('Emp 999 (should raise error)', fn_annual_salary(999));
  EXCEPTION WHEN OTHERS THEN show('Emp 999', SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('===== B2 fn_years_of_service =====');
  show('Emp 101 (hired 2015-03-15)', fn_years_of_service(101));
  show('Emp 105 (hired 2024-05-20)', fn_years_of_service(105));
  BEGIN
    show('Emp 999 (should raise error)', fn_years_of_service(999));
  EXCEPTION WHEN OTHERS THEN show('Emp 999', SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('===== B3 fn_calculate_tax =====');
  show('Salary 0       (expect 0)',      fn_calculate_tax(0));
  show('Salary 55000   (expect 0)',      fn_calculate_tax(55000));
  show('Salary 60000   (expect 0)',      fn_calculate_tax(60000));
  show('Salary 80000   (expect 4000)',   fn_calculate_tax(80000));
  show('Salary 100000  (expect 8000)',   fn_calculate_tax(100000));
  show('Salary 250000  (expect 53000)',  fn_calculate_tax(250000));
  show('Salary 850000  (expect 233000)', fn_calculate_tax(850000));
  BEGIN
    show('Salary -5 (should raise error)', fn_calculate_tax(-5));
  EXCEPTION WHEN OTHERS THEN show('Salary -5', SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('===== B4 fn_dept_name =====');
  show('Dept 10',          fn_dept_name(10));
  show('Dept 20',          fn_dept_name(20));
  show('Dept 99 (no row)', fn_dept_name(99));
  show('Dept NULL',        fn_dept_name(NULL));
END;
/
