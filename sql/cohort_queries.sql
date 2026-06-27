
-- ============================================================
-- SAAS COHORT RETENTION ANALYSIS — SQL Queries
-- Database: data/cohort.db
-- Tables: subscribers, activity
-- ============================================================

-- 1. BUSINESS SUMMARY
SELECT
    COUNT(DISTINCT subscriber_id)       AS total_subscribers,
    COUNT(DISTINCT cohort_month)        AS total_cohorts,
    ROUND(SUM(monthly_price), 2)        AS total_mrr_at_signup
FROM subscribers;

-- 2. COHORT RETENTION TABLE
WITH cohort_size AS (
    SELECT cohort_month,
           COUNT(DISTINCT subscriber_id) AS cohort_subscribers
    FROM subscribers
    GROUP BY cohort_month
),
monthly_active AS (
    SELECT cohort_month,
           month_number,
           COUNT(DISTINCT subscriber_id) AS active_subscribers
    FROM activity
    GROUP BY cohort_month, month_number
)
SELECT
    m.cohort_month,
    m.month_number,
    ROUND(m.active_subscribers * 100.0 /
          c.cohort_subscribers, 1)      AS retention_pct
FROM monthly_active m
JOIN cohort_size c ON m.cohort_month = c.cohort_month
ORDER BY m.cohort_month, m.month_number;

-- 3. CHURN BY PLAN
WITH last_active AS (
    SELECT subscriber_id,
           MAX(month_number)            AS last_month
    FROM activity
    GROUP BY subscriber_id
)
SELECT
    s.plan,
    COUNT(*)                            AS total_subscribers,
    ROUND(SUM(CASE WHEN l.last_month < 24
              THEN 1 ELSE 0 END) * 100.0 /
          COUNT(*), 1)                  AS churn_rate_pct
FROM subscribers s
JOIN last_active l ON s.subscriber_id = l.subscriber_id
GROUP BY s.plan
ORDER BY churn_rate_pct DESC;

-- 4. SUBSCRIBER LTV WITH WINDOW FUNCTION
WITH subscriber_monthly AS (
    SELECT subscriber_id, plan, monthly_price, month_number,
           SUM(monthly_price) OVER (
               PARTITION BY subscriber_id
               ORDER BY month_number
           )                            AS cumulative_revenue
    FROM activity
)
SELECT
    plan,
    month_number,
    ROUND(AVG(cumulative_revenue), 2)   AS avg_cumulative_ltv
FROM subscriber_monthly
WHERE month_number IN (0, 1, 3, 6, 12)
GROUP BY plan, month_number
ORDER BY plan, month_number;
