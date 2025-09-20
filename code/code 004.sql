// List all departments (department_id, department_name) 
// that have employees assigned to them and 
// belong to the specified department IDs (10, 20, 30). 
// Show the number of employees in each department.
// Ensure the results are unique and 
// sorted by department_id in ascending order.

SELECT 
    d.department_id, 
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
WHERE d.department_id IN (10, 20, 30)
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id ASC;