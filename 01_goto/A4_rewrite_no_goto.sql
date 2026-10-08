-- ============================================================
-- A4 - Rewrite WITHOUT GOTO
-- Same behaviour as A1 and A2, using structured IF / CASE.
-- ============================================================
SET SERVEROUTPUT ON

-- ---------- A1 rewritten: Number classifier ----------
DECLARE
  v_numbers SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(15, -8, 0, 7, -3, 100);
  v_num     NUMBER;
  v_sign    VARCHAR2(20);
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- A1 without GOTO ---');
  FOR i IN 1 .. v_numbers.COUNT LOOP
    v_num := v_numbers(i);

    IF v_num = 0 THEN
      DBMS_OUTPUT.PUT_LINE(v_num || ' is zero (neither positive nor negative, no parity check)');
    ELSE
      v_sign := CASE WHEN v_num > 0 THEN 'positive' ELSE 'negative' END;
      DBMS_OUTPUT.PUT_LINE(v_num || ' is ' || v_sign || ' and ' ||
                           CASE MOD(v_num, 2) WHEN 0 THEN 'EVEN' ELSE 'ODD' END);
    END IF;
  END LOOP;
END;
/

-- ---------- A2 rewritten: Salary review ----------
DECLARE
  v_band      VARCHAR2(10);
  v_raise_pct NUMBER;
  v_new_sal   NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- A2 without GOTO ---');
  FOR r IN (SELECT emp_id, first_name, last_name, salary
              FROM employees
             WHERE salary IS NOT NULL
             ORDER BY emp_id) LOOP

    IF r.salary < 300000 THEN
      v_band := 'LOW';  v_raise_pct := 10;
    ELSIF r.salary < 600000 THEN
      v_band := 'MID';  v_raise_pct := 5;
    ELSE
      v_band := 'HIGH'; v_raise_pct := 2;
    END IF;

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
