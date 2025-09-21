-- Source:
-- https://livesql.oracle.com/next/
-- This PL/SQL block demonstrates the use of cursors, date functions, 
-- and string concatenation in PL/SQL.
-- Ensure that server output is enabled to see the results.
SET SERVEROUTPUT ON;

DECLARE
    CURSOR emp_cur IS
        SELECT
            EMPLOYEE_ID,
            FIRST_NAME,
            LAST_NAME,
            EXTRACT(YEAR FROM HIRE_DATE) AS HIRE_YEAR,
            TO_CHAR(HIRE_DATE, 'Month') AS HIRE_MONTH,
            EXTRACT(DAY FROM HIRE_DATE) AS HIRE_DAY,
            TO_CHAR(HIRE_DATE, 'day') AS HIRE_DAY2
        FROM
            HR.EMPLOYEES
        ORDER BY
            EMPLOYEE_ID;

    -- Variables to hold column data
    v_employee_id HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_first_name  HR.EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name   HR.EMPLOYEES.LAST_NAME%TYPE;
    v_hire_year   NUMBER;
    v_hire_month  VARCHAR2(20);
    v_hire_day    NUMBER;
    v_hire_day2   VARCHAR2(10);
BEGIN
    FOR emp_rec IN emp_cur LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || emp_rec.EMPLOYEE_ID ||
            ', Name: ' || emp_rec.FIRST_NAME || ' ' || emp_rec.LAST_NAME ||
            ', Year: ' || emp_rec.HIRE_YEAR ||
            ', Month: ' || emp_rec.HIRE_MONTH ||
            ', Day: ' || emp_rec.HIRE_DAY ||
            ', Day Name: ' || emp_rec.HIRE_DAY2
        );
    END LOOP;
END;
/