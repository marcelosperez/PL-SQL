-- Source:
-- https://livesql.oracle.com/next/
-- This PL/SQL block retrieves and displays the first name, last name, and salary 
-- of employees who work in the same department(s) as any employee with the last 
-- name 'Grant', excluding employees whose last name is 'Grant'.
-- OBS: code 001 Oracle SQL altered 
DECLARE
  CURSOR c_employees IS
    SELECT first_name, last_name, salary
    FROM hr.employees
    WHERE department_id IN (
              SELECT department_id
              FROM hr.employees
              WHERE last_name = 'Grant')
      AND last_name != 'Grant';
BEGIN
  FOR rec IN c_employees LOOP
    DBMS_OUTPUT.PUT_LINE('First Name: ' || rec.first_name || ', Last Name: ' || rec.last_name || ', Salary: ' || rec.salary);
  END LOOP;
END;
/