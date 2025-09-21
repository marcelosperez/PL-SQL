-- Source:
-- https://livesql.oracle.com/next/
-- Educational PL/SQL Tutorial: Understanding STRING Aggregation in Oracle
-- This script teaches students how to use LISTAGG() function (Oracle's equivalent to STRING_AGG)
-- Working with the Oracle HR schema to demonstrate practical string aggregation examples
-- Note: Oracle uses LISTAGG instead of STRING_AGG function
SET SERVEROUTPUT ON;

DECLARE
    -- Variables to demonstrate different LISTAGG examples
    v_job_titles VARCHAR2(4000);
    v_employee_count NUMBER;
    
    -- Cursor to show employees grouped by department with string aggregation
    CURSOR dept_employees_cur IS
        SELECT 
            d.department_name,
            LISTAGG(e.first_name || ' ' || e.last_name, ', ') 
                WITHIN GROUP (ORDER BY e.last_name) AS employee_list,
            COUNT(e.employee_id) AS emp_count
        FROM hr.departments d
        LEFT JOIN hr.employees e ON d.department_id = e.department_id
        WHERE d.department_name IS NOT NULL
        GROUP BY d.department_name
        HAVING COUNT(e.employee_id) > 0
        ORDER BY d.department_name;
        
    -- Cursor to show salary ranges by job title using string aggregation
    CURSOR job_salary_cur IS
        SELECT 
            j.job_title,
            LISTAGG(e.first_name || ' ($' || e.salary || ')', ' | ') 
                WITHIN GROUP (ORDER BY e.salary DESC) AS salary_list
        FROM hr.jobs j
        JOIN hr.employees e ON j.job_id = e.job_id
        WHERE j.job_title IN ('Sales Representative', 'Programmer', 'Accountant')
        GROUP BY j.job_title
        ORDER BY j.job_title;

BEGIN
    -- Introduction to STRING aggregation concept
    DBMS_OUTPUT.PUT_LINE('=== ORACLE STRING AGGREGATION TUTORIAL ===');
    DBMS_OUTPUT.PUT_LINE('Teaching LISTAGG() - Oracle''s version of STRING_AGG()');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Example 1: Simple LISTAGG to get all job titles
    DBMS_OUTPUT.PUT_LINE('Example 1: Getting all unique job titles in one string');
    SELECT LISTAGG(DISTINCT job_title, ', ') WITHIN GROUP (ORDER BY job_title)
    INTO v_job_titles
    FROM hr.jobs;
    
    DBMS_OUTPUT.PUT_LINE('All Job Titles: ' || v_job_titles);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Example 2: Employees by Department (most common use case)
    DBMS_OUTPUT.PUT_LINE('Example 2: Employees grouped by department using LISTAGG');
    DBMS_OUTPUT.PUT_LINE('LISTAGG syntax: LISTAGG(column, ''delimiter'') WITHIN GROUP (ORDER BY column)');
    DBMS_OUTPUT.PUT_LINE('');
    
    FOR dept_rec IN dept_employees_cur LOOP
        DBMS_OUTPUT.PUT_LINE('Department: ' || dept_rec.department_name || 
                            ' (' || dept_rec.emp_count || ' employees)');
        DBMS_OUTPUT.PUT_LINE('Employees: ' || dept_rec.employee_list);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Example 3: Different delimiter and data formatting
    DBMS_OUTPUT.PUT_LINE('Example 3: Using different delimiters and formatting data');
    DBMS_OUTPUT.PUT_LINE('Here we show employees with salaries, using pipe (|) as delimiter:');
    DBMS_OUTPUT.PUT_LINE('');
    
    FOR job_rec IN job_salary_cur LOOP
        DBMS_OUTPUT.PUT_LINE('Job: ' || job_rec.job_title);
        DBMS_OUTPUT.PUT_LINE('Employees with Salaries: ' || job_rec.salary_list);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Teaching summary
    DBMS_OUTPUT.PUT_LINE('=== KEY LEARNING POINTS ===');
    DBMS_OUTPUT.PUT_LINE('1. Oracle uses LISTAGG() instead of STRING_AGG()');
    DBMS_OUTPUT.PUT_LINE('2. Always include WITHIN GROUP (ORDER BY ...) clause');
    DBMS_OUTPUT.PUT_LINE('3. Use any delimiter: comma, pipe, semicolon, etc.');
    DBMS_OUTPUT.PUT_LINE('4. Combine with GROUP BY for powerful data summarization');
    DBMS_OUTPUT.PUT_LINE('5. Format data before aggregating for better readability');
    DBMS_OUTPUT.PUT_LINE('6. Use DISTINCT to avoid duplicate values in the list');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Common uses: Creating reports, summary lists, CSV exports');
    
END;
/