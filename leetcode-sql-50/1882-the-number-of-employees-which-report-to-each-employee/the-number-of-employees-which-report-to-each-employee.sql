WITH
    Managers AS (
        SELECT
            employee_id AS manager_id,
            name
        FROM
            Employees
    )
SELECT
    manager_id AS employee_id,
    m.name,
    COUNT(manager_id) AS reports_count,
    ROUND(AVG(age), 0) AS average_age
FROM
    Employees e
    LEFT JOIN Managers m ON e.reports_to = m.manager_id
WHERE
    manager_id IS NOT NULL
GROUP BY
    manager_id
ORDER BY
    employee_id;