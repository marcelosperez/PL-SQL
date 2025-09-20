// List all departments (department_id, department_name) 
// that have employees assigned to them and 
// belong to the specified department IDs (10, 20, 30). 
// Ensure the results are unique and 
// sorted by department_id in ascending order.

SELECT DISTINCT d.department_id, d.department_name
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
WHERE d.department_id IN (10, 20, 30)
ORDER BY d.department_id ASC;