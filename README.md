# PL/SQL GOTO Statements and Functions — Individual Assignment III

![Oracle](https://img.shields.io/badge/Oracle-PL%2FSQL-red)
![Course](https://img.shields.io/badge/Course-INSY%208311-blue)
![Assignment](https://img.shields.io/badge/Assignment-III-green)
![Status](https://img.shields.io/badge/Status-Completed-success)

##  Student Information

| Field | Details |
|---|---|
| **Student Name** | **Mutesi Liza Phiona** |
| **Student ID** | **29793** |
| **Course** | Database Development with PL/SQL (INSY 8311) |
| **Instructor** | Eric Maniraguha |
| **Assignment** | Individual Assignment III |
| **Topic** | PL/SQL GOTO Statements and Functions |
| **Date** | October 7, 2026 |

---

##  Assignment Overview

This repository contains my implementation of **Individual Assignment III** for Database Development with PL/SQL.

The assignment focuses on practical use of:

- PL/SQL `GOTO` statements
- Stored functions
- Exception handling
- Functions used inside SQL statements
- Validation and error handling
- Structured programming without `GOTO`
- GitHub repository organization and documentation

The assignment is divided into three main sections:

### Part A — GOTO Statements
- **A1:** Number Classifier
- **A2:** Salary Review
- **A3:** Illegal GOTO and Fix
- **A4:** Rewrite Without GOTO

### Part B — Stored Functions
- **B1:** Annual Salary
- **B2:** Years of Service
- **B3:** Tax Calculator
- **B4:** Department Name
- **B5:** Functions in SQL

### Part C — Combined Task
- **C1:** Payroll Validator
- **C2:** Reflection



---

#  Repository Structure

```text
plsql-goto-functions-<studentID>-<firstname>/
│
├── README.md
├── .gitignore
├── git_commands.sh
│
├── 00_setup/
│   └── create_tables.sql
│
├── 01_goto/
│   ├── A1_number_classifier.sql
│   ├── A2_salary_review.sql
│   ├── A3_illegal_goto.sql
│   └── A4_rewrite_no_goto.sql
│
├── 02_functions/
│   ├── B1_fn_annual_salary.sql
│   ├── B2_fn_years_of_service.sql
│   ├── B3_fn_calculate_tax.sql
│   ├── B4_fn_dept_name.sql
│   └── C1_fn_validate_payroll.sql
│
├── 03_tests/
│   ├── B5_functions_in_select.sql
│   ├── test_functions.sql
│   └── test_validate_payroll.sql
│
├── screenshots/
│   ├── A1_output.png
│   ├── A2_output.png
│   ├── A3_error_and_fix.png
│   ├── A4_output.png
│   ├── B5_select_output.png
│   └── C1_output.png
│
└── docs/
    ├── REFLECTION.md
    └── QUIZ_PREP.md
```



---

#  Database Setup

The project uses two main tables:

### `DEPARTMENTS`

Stores department information.

| Column | Description |
|---|---|
| `DEPT_ID` | Unique department identifier |
| `DEPT_NAME` | Department name |

### `EMPLOYEES`

Stores employee payroll information.

| Column | Description |
|---|---|
| `EMP_ID` | Unique employee identifier |
| `FIRST_NAME` | Employee first name |
| `LAST_NAME` | Employee last name |
| `DEPT_ID` | Employee department |
| `SALARY` | Monthly gross salary in RWF |
| `BONUS` | Yearly bonus |
| `HIRE_DATE` | Employee hiring date |

The setup script creates both tables, inserts sample departments and employees, and commits the data.

---

#  Part A — GOTO Statements

## A1 — Number Classifier

**File:**

```text
01_goto/A1_number_classifier.sql
```

This program demonstrates the use of `GOTO` to classify numbers as:

- Positive
- Negative
- Zero
- Even
- Odd

Zero is treated separately because it is neither positive nor negative.

The program uses labels such as:

```sql
<<is_positive>>
<<is_negative>>
<<is_zero>>
<<check_parity>>
<<finish>>
```

This demonstrates how program control can be transferred to different sections of a PL/SQL block.

---

## A2 — Salary Review

**File:**

```text
01_goto/A2_salary_review.sql
```

The salary review program uses `GOTO` to place employees into salary bands.

| Salary | Band | Proposed Raise |
|---:|---|---:|
| Less than 300,000 RWF | LOW | 10% |
| 300,000–599,999 RWF | MID | 5% |
| 600,000 RWF and above | HIGH | 2% |

The program calculates a proposed salary but **does not modify the employee table**.

This allows the use of `GOTO` to transfer execution to the appropriate salary-band calculation before reaching a common output section.

---

## A3 — Illegal GOTO and Fix

**File:**

```text
01_goto/A3_illegal_goto.sql
```

This task demonstrates an important PL/SQL restriction:

> A `GOTO` cannot jump into an `IF`, `LOOP`, `CASE`, inner block, or exception handler.

The script intentionally contains an illegal `GOTO` to demonstrate the compiler error and then provides corrected versions.

The expected illegal-GOTO compiler error is:

```text
PLS-00375: illegal GOTO statement
```

Two legal fixes are demonstrated:

1. Moving the label to the appropriate block level.
2. Jumping from an inner block to a label in an enclosing block.

---

## A4 — Rewrite Without GOTO

**File:**

```text
01_goto/A4_rewrite_no_goto.sql
```

A1 and A2 are rewritten using structured programming techniques such as:

```sql
IF
ELSIF
ELSE
CASE
```

The purpose is to demonstrate that the same logic can be implemented without unconditional jumps.

This version provides a clearer top-to-bottom program flow and is easier to read and maintain.

---

#  Part B — Stored Functions

## B1 — Annual Salary

**File:**

```text
02_functions/B1_fn_annual_salary.sql
```

### Function

```text
fn_annual_salary(p_emp_id)
```

### Calculation

```text
Annual Salary = Monthly Salary × 12 + Yearly Bonus
```

If the bonus is `NULL`, it is treated as zero.

The function also handles an employee ID that does not exist by raising an application error.

---

## B2 — Years of Service

**File:**

```text
02_functions/B2_fn_years_of_service.sql
```

### Function

```text
fn_years_of_service(p_emp_id)
```

The function calculates the employee's complete years of service using the employee's `HIRE_DATE` and the current date.

The calculation uses:

```sql
TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)
```

The function also validates that the employee exists and that the hire date is not in the future.

---

## B3 — Tax Calculator

**File:**

```text
02_functions/B3_fn_calculate_tax.sql
```

### Function

```text
fn_calculate_tax(p_salary)
```

The function calculates progressive monthly tax according to the brackets implemented in this project:

| Monthly Salary | Tax |
|---:|---:|
| 0–60,000 RWF | 0% |
| 60,001–100,000 RWF | 20% of amount above 60,000 |
| Above 100,000 RWF | 8,000 + 30% of amount above 100,000 |

Negative or `NULL` salaries are rejected using `RAISE_APPLICATION_ERROR`.

---

## B4 — Department Name

**File:**

```text
02_functions/B4_fn_dept_name.sql
```

### Function

```text
fn_dept_name(p_dept_id)
```

The function receives a department ID and returns its department name.

If the department does not exist or the department ID is `NULL`, the function returns:

```text
Unknown
```

---

#  B5 — Functions Used in SQL

**File:**

```text
03_tests/B5_functions_in_select.sql
```

The stored functions are demonstrated inside SQL statements.

Functions are used in:

### SELECT

```sql
SELECT ...
       fn_dept_name(e.dept_id),
       fn_annual_salary(e.emp_id),
       fn_years_of_service(e.emp_id),
       fn_calculate_tax(e.salary)
FROM employees e;
```

### WHERE

```sql
WHERE fn_years_of_service(emp_id) >= 5;
```

### ORDER BY

```sql
ORDER BY fn_annual_salary(emp_id) DESC;
```

This demonstrates that stored PL/SQL functions can be integrated directly into SQL queries.

---

#  Part C — Payroll Validator

## C1 — Payroll Validator

**File:**

```text
02_functions/C1_fn_validate_payroll.sql
```

### Function

```text
fn_validate_payroll(p_emp_id)
```

The payroll validator combines several concepts from the assignment.

It checks:

1. Whether the employee exists.
2. Whether the employee has a valid positive salary.
3. Whether the employee has a valid department.
4. Whether the hire date is valid.
5. Whether calculated tax is lower than the salary.

The function returns either:

```text
VALID: ...
```

or:

```text
INVALID: ...
```

The function also demonstrates the use of `GOTO` to direct invalid cases to a common result section.

---

#  Testing

The project includes dedicated testing scripts.

### General function tests

```text
03_tests/test_functions.sql
```

Tests include:

- Existing employees
- Non-existing employees
- Different salary values
- Invalid salary values
- Different departments
- Missing departments
- Years of service

### Payroll validation tests

```text
03_tests/test_validate_payroll.sql
```

The test script includes both valid and intentionally invalid employee records.

Temporary test records are inserted for validation and removed using:

```sql
ROLLBACK;
```

This prevents the temporary test data from permanently changing the database.

---

# ▶️ How to Run the Project



## Step 1 — Create the tables

Run:

```sql
@00_setup/create_tables.sql
```

This creates:

```text
DEPARTMENTS
EMPLOYEES
```

and inserts the sample data.

---

## Step 2 — Create the functions

Run the functions in this order:

```sql
@02_functions/B1_fn_annual_salary.sql
@02_functions/B2_fn_years_of_service.sql
@02_functions/B3_fn_calculate_tax.sql
@02_functions/B4_fn_dept_name.sql
@02_functions/C1_fn_validate_payroll.sql
```

`C1` should be runned after the other required functions because it uses functions such as `fn_calculate_tax` and `fn_dept_name`.

---

## Step 3 — Run the GOTO programs

Run:

```sql
@01_goto/A1_number_classifier.sql
@01_goto/A2_salary_review.sql
@01_goto/A3_illegal_goto.sql
@01_goto/A4_rewrite_no_goto.sql
```

---

## Step 4 — Run the tests

Run:

```sql
@03_tests/B5_functions_in_select.sql
@03_tests/test_functions.sql
@03_tests/test_validate_payroll.sql
```

---

## Step 5 — Verify the results

Check:

- Console output
- Function compilation status
- Error messages for intentionally invalid cases
- SQL query results
- Payroll validation results



---

#  Screenshots

The repository includes screenshots for the main practical outputs:

| Screenshot | Purpose |
|---|---|
| `A1_output.png` | Number classifier output |
| `A2_output.png` | Salary review output |
| `A3_error_and_fix.png` | Illegal GOTO error and corrected code |
| `A4_output.png` | Version rewritten without GOTO |
| `B5_select_output.png` | Functions used inside SQL |
| `C1_output.png` | Payroll validation results |

These correspond to the screenshot requirements listed in the assignment structure.

---

# 📚 Key PL/SQL Concepts Demonstrated

### GOTO

```sql
GOTO label;

<<label>>
DBMS_OUTPUT.PUT_LINE('Message');
```

A `GOTO` transfers execution to a labeled statement.

### Stored Function

```sql
CREATE OR REPLACE FUNCTION function_name (...)
RETURN datatype
IS
BEGIN
    ...
    RETURN value;
END;
/
```

A function must return a value.

### Exception Handling

The project demonstrates:

```sql
NO_DATA_FOUND
```

and:

```sql
RAISE_APPLICATION_ERROR
```

for handling invalid situations.

### `%TYPE`

The project uses `%TYPE` to derive variable types from table columns.

Example:

```sql
v_salary employees.salary%TYPE;
```

### `%ROWTYPE`

The payroll validator uses `%ROWTYPE` to represent a complete employee record.

Example:

```sql
v_emp employees%ROWTYPE;
```

---

#  What I Learned

Through this assignment, I practiced using PL/SQL control-flow statements and stored functions in practical database scenarios.

I learned that `GOTO` can transfer control to a label, but it has important restrictions. In particular, a `GOTO` cannot jump into an `IF`, `LOOP`, `CASE`, inner block, or exception handler.

I also learned how structured `IF/ELSIF/ELSE` and `CASE` statements can replace `GOTO` logic and generally provide clearer program flow.

The function exercises helped me understand how reusable PL/SQL logic can be created and then called from ordinary SQL statements such as `SELECT`, `WHERE`, and `ORDER BY`.

Exception handling was also important because functions need to handle situations such as missing employees, invalid input, and unexpected database conditions.

---

#  AI Usage

I used an AI assistant as a learning and development aid during this assignment.

The AI assistant helped me with:

- Understanding PL/SQL concepts
- Structuring SQL and PL/SQL scripts
- Reviewing syntax
- Explaining errors


I remained responsible for running, testing, reviewing, and understanding the submitted code.

---




##  Conclusion

This project demonstrates practical application of **PL/SQL GOTO statements, stored functions, exception handling, SQL-integrated functions, validation, testing, and GitHub documentation**.

The main objective was not only to produce working SQL scripts, but also to understand how PL/SQL control flow and reusable functions can be applied to real database and payroll-related scenarios.
