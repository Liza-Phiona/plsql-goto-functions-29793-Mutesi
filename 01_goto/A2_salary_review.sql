-- ============================================================
-- A2 - Salary Review (using GOTO)
-- For every employee, jump to a salary band and compute a
-- proposed raise %, then fall through to a common print section.
--   LOW  band : salary <  300,000  -> 10% raise
--   MID  band : 300,000 - 599,999  ->  5% raise
--   HIGH band : salary >= 600,000  ->  2% raise
-- (Display only - no data is changed.)
-- ============================================================
SET SERVEROUTPUT ON

DECLARE
  v_band      VARCHAR2(10);
  v_raise_pct NUMBER;
  v_new_sal   NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('=== SALARY REVIEW ===');

  FOR r IN (SELECT emp_id, first_name, last_name, salary
              FROM employees
             WHERE salary IS NOT NULL
             ORDER BY emp_id) LOOP

    IF r.salary < 300000 THEN
      GOTO low_band;
    ELSIF r.salary < 600000 THEN
      GOTO mid_band;
    ELSE
      GOTO high_band;
    END IF;

    <<low_band>>
    v_band := 'LOW';  v_raise_pct := 10;
    GOTO print_result;

    <<mid_band>>
    v_band := 'MID';  v_raise_pct := 5;
    GOTO print_result;

    <<high_band>>
    v_band := 'HIGH'; v_raise_pct := 2;

    <<print_result>>
    v_new_sal := r.salary * (1 + v_raise_pct / 100);
    DBMS_OUTPUT.PUT_LINE(
      RPAD(r.emp_id || ' ' || r.first_name || ' ' || r.last_name, 28) ||
      RPAD('Band: ' || v_band, 12) ||
      'Current: ' || LPAD(TO_CHAR(r.salary, 'FM999,999,990'), 9) ||
      '  Raise: ' || LPAD(v_raise_pct, 2) || '%' ||
      '  Proposed: ' || TO_CHAR(v_new_sal, 'FM999,999,990'));
  END LOOP;
END;
/
