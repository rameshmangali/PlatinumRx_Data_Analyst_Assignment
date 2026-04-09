-- 04_Clinic_Queries.sql
-- Clinic Management System - Queries for Part B
-- Modified to be fully compatible with MySQL 5.7 (Without CTEs, Window Functions, or FULL OUTER JOIN)

-- 1. Find the revenue we got from each sales channel in a given year (e.g., 2021)
SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY sales_channel;

-- 2. Find top 10 the most valuable customers for a given year (e.g., 2021)
SELECT 
    uid,
    SUM(amount) AS total_spent
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- 3. Find month wise revenue, expense, profit, status (profitable / not-profitable) for a given year
SELECT 
    m.month_num,
    COALESCE(r.revenue, 0) AS revenue,
    COALESCE(e.expense, 0) AS expense,
    (COALESCE(r.revenue, 0) - COALESCE(e.expense, 0)) AS profit,
    CASE 
        WHEN (COALESCE(r.revenue, 0) - COALESCE(e.expense, 0)) > 0 THEN 'profitable' 
        ELSE 'not-profitable' 
    END AS status
FROM (
    SELECT DISTINCT EXTRACT(MONTH FROM datetime) AS month_num FROM clinic_sales WHERE EXTRACT(YEAR FROM datetime) = 2021
    UNION
    SELECT DISTINCT EXTRACT(MONTH FROM datetime) AS month_num FROM expenses WHERE EXTRACT(YEAR FROM datetime) = 2021
) m
LEFT JOIN (
    SELECT EXTRACT(MONTH FROM datetime) AS month_num, SUM(amount) AS revenue
    FROM clinic_sales 
    WHERE EXTRACT(YEAR FROM datetime) = 2021 
    GROUP BY EXTRACT(MONTH FROM datetime)
) r ON m.month_num = r.month_num
LEFT JOIN (
    SELECT EXTRACT(MONTH FROM datetime) AS month_num, SUM(amount) AS expense
    FROM expenses 
    WHERE EXTRACT(YEAR FROM datetime) = 2021 
    GROUP BY EXTRACT(MONTH FROM datetime)
) e ON m.month_num = e.month_num
ORDER BY m.month_num;


-- 4. For each city find the most profitable clinic for a given month (e.g. Month = 10, Year = 2021)
SELECT 
    c.city, 
    c.cid, 
    (COALESCE(r.rev, 0) - COALESCE(e.exp, 0)) AS profit
FROM clinics c
LEFT JOIN (
    SELECT cid, SUM(amount) AS rev FROM clinic_sales 
    WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
) r ON c.cid = r.cid
LEFT JOIN (
    SELECT cid, SUM(amount) AS exp FROM expenses 
    WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
) e ON c.cid = e.cid
WHERE (r.rev IS NOT NULL OR e.exp IS NOT NULL)
AND (
    SELECT COUNT(DISTINCT (COALESCE(r2.rev, 0) - COALESCE(e2.exp, 0)))
    FROM clinics c2
    LEFT JOIN (
        SELECT cid, SUM(amount) AS rev FROM clinic_sales 
        WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
    ) r2 ON c2.cid = r2.cid
    LEFT JOIN (
        SELECT cid, SUM(amount) AS exp FROM expenses 
        WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
    ) e2 ON c2.cid = e2.cid
    WHERE c2.city = c.city 
      AND (r2.rev IS NOT NULL OR e2.exp IS NOT NULL)
      AND (COALESCE(r2.rev, 0) - COALESCE(e2.exp, 0)) > (COALESCE(r.rev, 0) - COALESCE(e.exp, 0))
) = 0;


-- 5. For each state find the second least profitable clinic for a given month (e.g. Month = 10, Year = 2021)
SELECT 
    c.state, 
    c.cid, 
    (COALESCE(r.rev, 0) - COALESCE(e.exp, 0)) AS profit
FROM clinics c
LEFT JOIN (
    SELECT cid, SUM(amount) AS rev FROM clinic_sales 
    WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
) r ON c.cid = r.cid
LEFT JOIN (
    SELECT cid, SUM(amount) AS exp FROM expenses 
    WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
) e ON c.cid = e.cid
WHERE (r.rev IS NOT NULL OR e.exp IS NOT NULL)
AND (
    SELECT COUNT(DISTINCT (COALESCE(r2.rev, 0) - COALESCE(e2.exp, 0)))
    FROM clinics c2
    LEFT JOIN (
        SELECT cid, SUM(amount) AS rev FROM clinic_sales 
        WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
    ) r2 ON c2.cid = r2.cid
    LEFT JOIN (
        SELECT cid, SUM(amount) AS exp FROM expenses 
        WHERE EXTRACT(MONTH FROM datetime) = 10 AND EXTRACT(YEAR FROM datetime) = 2021 GROUP BY cid
    ) e2 ON c2.cid = e2.cid
    WHERE c2.state = c.state 
      AND (r2.rev IS NOT NULL OR e2.exp IS NOT NULL)
      AND (COALESCE(r2.rev, 0) - COALESCE(e2.exp, 0)) < (COALESCE(r.rev, 0) - COALESCE(e.exp, 0))
) = 1;
