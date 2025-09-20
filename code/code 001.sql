-- PL/SQL block to display the number of employees in specific departments
--
-- This script:
--   - Selects departments with IDs 10, 20, and 30.
--   - Counts the number of employees in each of these departments.
--   - Outputs the department ID, department name, and employee count for each.
--
-- OBS: code 001 Oracle SQL altered

DECLARE
    CURSOR dept_cur IS
        SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS employee_count
        FROM departments d
        INNER JOIN employees e ON d.department_id = e.department_id
        WHERE d.department_id IN (10, 20, 30)
        GROUP BY d.department_id, d.department_name
        ORDER BY d.department_id ASC;
BEGIN
    FOR rec IN dept_cur LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Department ID: ' || rec.department_id ||
            ', Name: ' || rec.department_name ||
            ', Employee Count: ' || rec.employee_count
        );
    END LOOP;
END;
/