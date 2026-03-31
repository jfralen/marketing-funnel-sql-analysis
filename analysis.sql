-- =========================
-- Funnel Performance
-- =========================

WITH funnel AS (
    SELECT
        (SELECT COUNT(DISTINCT session_id) FROM events WHERE event_type = 'view') AS views,
        (SELECT COUNT(DISTINCT session_id) FROM events WHERE event_type = 'click') AS clicks,
        (SELECT COUNT(DISTINCT session_id) FROM events WHERE event_type = 'add_to_cart') AS add_to_cart,
        (SELECT COUNT(DISTINCT session_id) FROM events WHERE event_type = 'purchase') AS purchases,
        (SELECT COUNT(DISTINCT session_id) FROM events WHERE event_type = 'bounce') AS bounces
)
SELECT
    views,
    clicks,
    add_to_cart,
    purchases,
    bounces,
    ROUND(1.0 * clicks / NULLIF(views, 0), 4) AS view_to_click_rate,
    ROUND(1.0 * add_to_cart / NULLIF(clicks, 0), 4) AS click_to_cart_rate,
    ROUND(1.0 * purchases / NULLIF(add_to_cart, 0), 4) AS cart_to_purchase_rate,
    ROUND(1.0 * purchases / NULLIF(views, 0), 4) AS overall_purchase_rate,
    ROUND(1.0 * bounces / NULLIF(views, 0), 4) AS bounce_rate
FROM funnel;

-- =========================
-- Traffic Source Funnel
-- =========================

WITH traffic_funnel AS (
    SELECT
        LOWER(TRIM(traffic_source)) AS traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'view' THEN session_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'click' THEN session_id END) AS clicks,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN session_id END) AS add_to_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN session_id END) AS purchases,
        COUNT(DISTINCT CASE WHEN event_type = 'bounce' THEN session_id END) AS bounces
    FROM events
    GROUP BY LOWER(TRIM(traffic_source))
)
SELECT
    *,
    ROUND(1.0 * clicks / NULLIF(views, 0), 4) AS view_to_click_rate,
    ROUND(1.0 * purchases / NULLIF(views, 0), 4) AS overall_purchase_rate
FROM traffic_funnel
ORDER BY overall_purchase_rate DESC;

-- =========================
-- Campaign Performance
-- =========================

SELECT
    c.channel,
    c.objective,
    COUNT(DISTINCT t.campaign_id) AS campaigns,
    COUNT(DISTINCT t.transaction_id) AS transactions,
    COUNT(DISTINCT t.customer_id) AS purchasing_customers,
    ROUND(SUM(t.gross_revenue), 2) AS total_revenue,
    ROUND(AVG(t.gross_revenue), 2) AS avg_order_value,
    SUM(CASE WHEN t.refund_flag = 1 THEN 1 ELSE 0 END) AS refunded_transactions,
    ROUND(1.0 * SUM(CASE WHEN t.refund_flag = 1 THEN 1 ELSE 0 END) 
          / NULLIF(COUNT(DISTINCT t.transaction_id), 0), 4) AS refund_rate
FROM transactions t
LEFT JOIN campaign c
    ON t.campaign_id = c.campaign_id
WHERE t.campaign_id IS NOT NULL
  AND t.campaign_id != 0
GROUP BY c.channel, c.objective
ORDER BY total_revenue DESC;