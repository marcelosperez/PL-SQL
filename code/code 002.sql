// Query to find the number of employees 
// in each department for departments with IDs 10, 20, and 30

SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
WHERE d.department_id IN (10, 20, 30)
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id ASC;