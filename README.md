# Database Problems and Solutions

A comprehensive collection of **102+ optimized SQL solutions** covering real-world database problems from LeetCode and HackerRank. This repository serves as both a learning resource and a reference guide for SQL techniques encountered in technical interviews and industry projects.

---

## Why This Repository?

Whether you're preparing for SQL interviews, learning database querying from scratch, or looking for optimized solutions to common data problems, this repository offers:

- **Progressive Learning Path** — Problems organized from basic to advanced, allowing structured skill development
- **Multiple Solution Approaches** — Many problems include alternative solutions demonstrating different SQL paradigms
- **Industry-Relevant Patterns** — Techniques directly applicable to reporting, analytics, and data engineering tasks
- **Platform Coverage** — Solutions from LeetCode SQL 50 study plan and HackerRank SQL certification tracks

---

## Repository Structure

```
SQL/
├── HackerRank SQL/
│   ├── Basic Select/        # 20 problems — foundational queries
│   ├── Aggregation/         # 17 problems — aggregate functions & grouping
│   ├── Basic Join/          #  7 problems — join operations
│   ├── Advanced Select/     #  4 problems — CASE, pivoting, complex logic
│   ├── Advanced Join/       #  1 problem  — multi-table aggregations
│   └── Recursive CTE/       #  3 problems — recursive patterns
│
└── leetcode-sql-50/         # 50 problems with difficulty badges
    └── {problem-number}-{problem-slug}/
        ├── README.md        # Problem description
        └── solution.sql     # Optimized solution
```

---

## SQL Techniques Covered

### Window Functions
Master analytical queries used extensively in reporting and data analysis:

| Technique | Use Case | Example Problems |
|-----------|----------|------------------|
| `DENSE_RANK()` | Top-N per group, percentile ranking | Department Top 3 Salaries |
| `ROW_NUMBER()` | Pagination, deduplication, pivot prep | Median calculation, Occupations |
| `LAG() / LEAD()` | Period-over-period comparison | Consecutive Numbers, Rising Temperature |
| `SUM() OVER (ROWS BETWEEN...)` | Rolling averages, cumulative totals | Restaurant Growth (7-day window) |
| `COUNT() OVER (PARTITION BY...)` | Running counts within groups | Game Play Analysis |

### Common Table Expressions (CTEs)
Improve query readability and enable complex transformations:

```sql
-- Standard CTE for query organization
WITH ranked_employees AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) as rnk
    FROM employees
)
SELECT * FROM ranked_employees WHERE rnk <= 3;
```

### Recursive CTEs
Generate sequences and traverse hierarchical data:

```sql
-- Prime number generator using recursive CTE
WITH RECURSIVE numbers AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 1000
)
SELECT GROUP_CONCAT(n SEPARATOR '&') FROM numbers
WHERE NOT EXISTS (SELECT 1 FROM numbers d WHERE d.n < numbers.n AND numbers.n % d.n = 0);
```

### Join Patterns
From simple lookups to complex multi-table aggregations:

- **Self-joins** — Comparing rows within the same table
- **Range joins** — Using `BETWEEN` for date ranges or numeric intervals
- **Derived tables** — Subqueries in FROM clause for pre-aggregation
- **Anti-joins** — `LEFT JOIN ... WHERE IS NULL` or `NOT EXISTS`

### Aggregation Techniques
Essential for reporting and analytics:

- Conditional aggregation: `SUM(CASE WHEN condition THEN 1 ELSE 0 END)`
- String aggregation: `GROUP_CONCAT()` with custom separators
- Filtered aggregation: `HAVING` clause for post-grouping filters
- NULL-safe operations: `COALESCE()`, `IFNULL()`

### Subquery Patterns
Powerful data retrieval techniques:

- **Scalar subqueries** — Single-value lookups in SELECT or WHERE
- **Correlated subqueries** — Row-by-row evaluation with outer reference
- **EXISTS / NOT EXISTS** — Efficient existence checks

---

## Featured Solutions

### Complex Multi-Table Aggregation
**Problem:** Interviews (HackerRank Advanced Join)  
**Challenge:** Aggregate data across 5+ related tables without duplicate inflation

```sql
-- Pre-aggregate to avoid Cartesian product multiplication
SELECT c.contest_id, c.hacker_id, c.name,
       SUM(ss.total_submissions), SUM(ss.total_accepted_submissions),
       SUM(vs.total_views), SUM(vs.total_unique_views)
FROM Contests c
JOIN Colleges col ON c.contest_id = col.contest_id
JOIN Challenges ch ON col.college_id = ch.college_id
LEFT JOIN (SELECT challenge_id, SUM(...) FROM ... GROUP BY challenge_id) ss ON ...
LEFT JOIN (SELECT challenge_id, SUM(...) FROM ... GROUP BY challenge_id) vs ON ...
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING SUM(ss.total_submissions) + SUM(vs.total_views) > 0;
```

### Rolling Window Calculation
**Problem:** Restaurant Growth (LeetCode 1321)  
**Challenge:** Calculate 7-day moving average of customer payments

```sql
SELECT visited_on, amount,
       ROUND(AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) as average_amount
FROM daily_totals
WHERE visited_on >= (SELECT MIN(visited_on) + INTERVAL 6 DAY FROM daily_totals);
```

### Dynamic Pivot Without PIVOT Operator
**Problem:** Occupations (HackerRank Advanced Select)  
**Challenge:** Transform rows to columns dynamically

```sql
SELECT MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
       MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
       MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
       MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor
FROM (SELECT name, occupation, ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) as rn
      FROM occupations) ranked
GROUP BY rn;
```

---

## Learning Path Recommendation

| Stage | Focus Areas | Folder |
|-------|-------------|--------|
| **1. Fundamentals** | SELECT, WHERE, ORDER BY, DISTINCT | `HackerRank SQL/Basic Select/` |
| **2. Aggregation** | GROUP BY, HAVING, COUNT, SUM, AVG | `HackerRank SQL/Aggregation/` |
| **3. Joins** | INNER, LEFT, self-joins, derived tables | `HackerRank SQL/Basic Join/` |
| **4. Subqueries** | Scalar, correlated, EXISTS patterns | `leetcode-sql-50/` (various) |
| **5. Window Functions** | RANK, ROW_NUMBER, LAG/LEAD, frames | `leetcode-sql-50/` (medium/hard) |
| **6. Advanced Patterns** | CTEs, recursive queries, pivoting | `HackerRank SQL/Recursive CTE/` |

---

## Who Should Use This Repository?

- **Interview Candidates** — Practice common SQL interview patterns with optimized solutions
- **Data Analysts** — Reference implementations for reporting queries
- **Backend Developers** — Learn efficient query patterns for application databases
- **Students** — Structured progression from basics to advanced techniques
- **Educators** — Ready-to-use examples for teaching SQL concepts

---

## Database Platform

All solutions are written for **MySQL** and use MySQL-specific syntax where applicable:
- `REGEXP` / `RLIKE` for pattern matching
- `GROUP_CONCAT()` for string aggregation
- `DATE_ADD()` with `INTERVAL` syntax
- Session variables with `SET @var = ...`

Most solutions can be adapted to PostgreSQL, SQL Server, or other databases with minor syntax adjustments.

---

## Contributing

Found an optimization or alternative approach? Contributions are welcome:

1. Fork the repository
2. Add your solution with clear comments
3. Include problem URL and complexity analysis if applicable
4. Submit a pull request

---

## License

This repository is open for educational use. Problem statements are property of their respective platforms (LeetCode, HackerRank).