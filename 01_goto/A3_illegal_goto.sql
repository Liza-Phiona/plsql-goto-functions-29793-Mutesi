-- ============================================================
-- A3 - Illegal GOTO and Fix
-- Rule: a GOTO may NOT jump INTO an IF / LOOP / CASE / inner
-- block / exception handler. It may only jump to a label that
-- is in the same block level, or in an ENCLOSING block.
-- ============================================================
SET SERVEROUTPUT ON

-- ---------- PART 1: ILLEGAL (will NOT compile) --------------
-- Expected error:
--   PLS-00375: illegal GOTO statement; this GOTO cannot branch to label 'INSIDE_IF'
-- (Take the screenshot of this error.)
DECLARE
  v_num NUMBER := 5;
BEGIN
  GOTO inside_if;                 -- tries to jump INTO the IF block -> ILLEGAL

  IF v_num > 0 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside the IF block');
  END IF;
END;
/

-- ---------- PART 2: FIX 1 - put the label at the block level ---
DECLARE
  v_num NUMBER := 5;
BEGIN
  IF v_num > 0 THEN
    GOTO positive_msg;            -- jumping OUT of the IF to an outer label is legal
  END IF;

  DBMS_OUTPUT.PUT_LINE('Not reached when v_num > 0');
  GOTO done;

  <<positive_msg>>
  DBMS_OUTPUT.PUT_LINE('FIX 1: label is at the block level, so GOTO works. v_num = ' || v_num);

  <<done>>
  NULL;
END;
/

-- ---------- PART 3: FIX 2 - jump from an inner block to an outer label ---
BEGIN
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Inner block running...');
    GOTO outer_label;             -- inner -> enclosing block is legal
  END;

  DBMS_OUTPUT.PUT_LINE('This line is skipped');

  <<outer_label>>
  DBMS_OUTPUT.PUT_LINE('FIX 2: jumped from inner block to enclosing block label.');
END;
/
