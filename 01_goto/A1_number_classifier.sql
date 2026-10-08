
SET SERVEROUTPUT ON

DECLARE
  v_numbers SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST(15, -8, 0, 7, -3, 100);
  v_num     NUMBER;
  v_sign    VARCHAR2(20);
BEGIN
  FOR i IN 1 .. v_numbers.COUNT LOOP
    v_num := v_numbers(i);

    
    IF v_num > 0 THEN
      GOTO is_positive;
    ELSIF v_num < 0 THEN
      GOTO is_negative;
    ELSE
      GOTO is_zero;
    END IF;

    <<is_positive>>
    v_sign := 'positive';
    GOTO check_parity;

    <<is_negative>>
    v_sign := 'negative';
    GOTO check_parity;

    <<is_zero>>
    DBMS_OUTPUT.PUT_LINE(v_num || ' is zero (neither positive nor negative, no parity check)');
    GOTO finish;

    -- Step 2: even / odd check
    <<check_parity>>
    IF MOD(v_num, 2) = 0 THEN
      DBMS_OUTPUT.PUT_LINE(v_num || ' is ' || v_sign || ' and EVEN');
    ELSE
      DBMS_OUTPUT.PUT_LINE(v_num || ' is ' || v_sign || ' and ODD');
    END IF;

    <<finish>>
    NULL;  -- a label must be followed by a statement
  END LOOP;
END;
/
