SELECT d.department_id, d.department_name, j.job_title
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE d.department_id IN (10, 20, 30)
ORDER BY d.department_id ASC;
