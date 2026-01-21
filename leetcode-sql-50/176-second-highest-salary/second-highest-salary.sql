WITH
    RankedEmployee AS (
        SELECT
            salary,
            DENSE_RANK() OVER (
                ORDER BY
                    salary DESC
            ) as rnk
        FROM
            Employee
    )
SELECT
    MAX(salary) AS SecondHighestSalary -- Using max function to return NULL in case of an empty set
FROM
    RankedEmployee
WHERE
    rnk = 2;