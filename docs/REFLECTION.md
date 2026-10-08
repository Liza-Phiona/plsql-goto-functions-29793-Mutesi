 C2 - Reflection

Course: Database Development with PL/SQL (INSY 8311)

Student: Mutesi Liza Phiona

StudentID: 29793

1. What did I learn about GOTO?
A `GOTO` transfers control unconditionally to a label written as `<<label>>`. It is legal only when the
label is in the same block level or an enclosing block. It can jump *out of* an IF/LOOP, but never *into* an
IF, LOOP, CASE branch, inner block or exception handler (error `PLS-00375`). A label must be followed by an
executable statement, so I used `NULL;` when nothing else followed.

2. Illegal GOTO (A3)
My first script jumped into an `IF` block and the compiler returned `PLS-00375`. I fixed it by moving the
label to the block level (Fix 1) and by jumping from an inner block to a label in the enclosing block (Fix 2).

 3. GOTO vs structured code (A4)
Rewriting A1 and A2 with `IF/ELSIF/CASE` gave the same results with fewer lines and a clear top-to-bottom
flow. GOTO creates "spaghetti code": harder to read, test and debug. I would normally avoid GOTO. The one place
it was reasonable was C1, where many validation checks share one failure exit point; even there, nested IFs or
a loop with `EXIT` could also be used.

4. Functions
A function must `RETURN` a value, can be called inside SQL (SELECT, WHERE, ORDER BY), and is best used for
calculations and lookups. A procedure does not return a value and is called as a statement. Functions called
from SQL should not perform DML (INSERT/UPDATE/DELETE). I used `%TYPE` and `%ROWTYPE` so the code adapts if
column definitions change.

 5. Exception handling
I used `NO_DATA_FOUND` and `RAISE_APPLICATION_ERROR` (codes -20001 to -20003) for invalid input, and returned
`'Unknown'` in `fn_dept_name` so a missing department does not break a SELECT.

6. Challenges and how I solved them
- A label cannot be the last thing before `END LOOP` - fixed with `NULL;`.
- Avoiding GOTO from an exception handler - I used a `COUNT(*)` check instead of catching `NO_DATA_FOUND`.
- Compile order: C1 depends on B3 and B4, so it must be compiled last.

7. AI usage statement
I used an AI assistant to help generate a first version of the code and structure. I then ran every
script myself in Oracle, reviewed each line, tested the results, and I can explain all the code.

