-- ============================================================
-- test_validate_payroll.sql - tests for C1 (valid + invalid cases)
-- Temporary rows (ids 901-904) are rolled back at the end.
-- Take the screenshot of this output for C1_output.png
-- ============================================================
SET SERVEROUTPUT ON

INSERT INTO employees VALUES (901, 'Zero',   'Salary',  10,   0,      NULL, DATE '2020-01-01');
INSERT INTO employees VALUES (902, 'No',     'Dept',    NULL, 300000, NULL, DATE '2020-01-01');
INSERT INTO employees VALUES (903, 'Future', 'Hire',    10,   300000, NULL, SYSDATE + 30);
INSERT INTO employees VALUES (904, 'Null',   'Salary',  10,   NULL,   NULL, DATE '2020-01-01');

BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Valid employees ---');
  FOR r IN (SELECT emp_id FROM employees WHERE emp_id < 900 ORDER BY emp_id) LOOP
    DBMS_OUTPUT.PUT_LINE(r.emp_id || ': ' || fn_validate_payroll(r.emp_id));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('--- Invalid cases ---');
  DBMS_OUTPUT.PUT_LINE('999 (not found)  : ' || fn_validate_payroll(999));
  DBMS_OUTPUT.PUT_LINE('901 (zero salary): ' || fn_validate_payroll(901));
  DBMS_OUTPUT.PUT_LINE('902 (no dept)    : ' || fn_validate_payroll(902));
  DBMS_OUTPUT.PUT_LINE('903 (future hire): ' || fn_validate_payroll(903));
  DBMS_OUTPUT.PUT_LINE('904 (null salary): ' || fn_validate_payroll(904));
END;
/

ROLLBACK;   -- remove the temporary test rows
