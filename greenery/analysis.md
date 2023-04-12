# General Analysis

## Week 1

**How many users do we have?**
- 130 users

```sql
SELECT DISTINCT COUNT(user_id) FROM dev_db.dbt_robynyurakicom.stg_users;
```

**On average, how many orders do we receive per hour?**
- 8 orders per hour

```sql
SELECT ROUND(AVG(counts)) AS avg_num_orders
FROM (
    SELECT
        DATE_TRUNC('HOUR', created_at) AS hours,
        COUNT(*) as counts
    FROM dev_db.dbt_robynyurakicom.stg_orders
    GROUP BY 1
);
```

**On average, how long does an order take from being placed to being delivered?**
- 3.89 days

```sql
SELECT
    ROUND(AVG(TIMESTAMPDIFF('day', created_at, delivered_at)), 2) AS avg_delivery_time_in_days
FROM dev_db.dbt_robynyurakicom.stg_orders
WHERE delivered_at IS NOT NULL
```

**How many users have only made one purchase? Two purchases? Three+ purchases?**
- One purchase: 25, two purchases: 28 and three or more purchases: 71

```sql
WITH orders_summary AS (
    SELECT
        user_id,
        count(order_id) num_of_orders
    FROM dev_db.dbt_robynyurakicom.stg_orders
    GROUP BY 1
    ORDER BY 2 DESC
)

SELECT
    count_if(num_of_orders = 1) AS one_order,
    count_if(num_of_orders = 2) AS two_orders,
    count_if(num_of_orders >= 3) AS three_or_more_orders
FROM orders_summary;
```

**On average, how many unique sessions do we have per hour?**
- 4

```sql
WITH unique_sessions AS (
    SELECT
        DISTINCT session_id,
        DATE_TRUNC('HOUR', created_at) AS hours,
        COUNT(*) as counts
    FROM dev_db.dbt_robynyurakicom.stg_events
    GROUP BY 1, 2
    ORDER BY 2
)

SELECT
    ROUND(AVG(counts)) AS avg_num_of_sessions
FROM unique_sessions
```