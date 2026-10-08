-- ============================================================
-- B3 - fn_calculate_tax(p_salary)
-- Monthly PAYE-style progressive tax (Rwanda-style brackets):
--   0       - 60,000   : 0%
--   60,001  - 100,000  : 20% of the part above 60,000
--   > 100,000          : 8,000 + 30% of the part above 100,000
-- ============================================================
CREATE OR REPLACE FUNCTION fn_calculate_tax (p_salary IN NUMBER)
RETURN NUMBER
IS
  v_tax NUMBER;
BEGIN
  IF p_salary IS NULL OR p_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Salary must be a non-negative number');
  END IF;

  IF p_salary <= 60000 THEN
    v_tax := 0;
  ELSIF p_salary <= 100000 THEN
    v_tax := (p_salary - 60000) * 0.20;
  ELSE
    v_tax := 8000 + (p_salary - 100000) * 0.30;
  END IF;

  RETURN ROUND(v_tax, 2);
END fn_calculate_tax;
/
SHOW ERRORS FUNCTION fn_calculate_tax
