DELETE P1
FROM
    Person P1
    JOIN Person P2
WHERE
    P1.email = p2.email
    AND P1.id > P2.id;