-- margin = revenue - purchase_cost
-- purchase_cost = quantity * purchase_price

WITH subquery AS (
  SELECT 
    orders_id,
    date_date,
    revenue,
    quantity,
    purchase_cost,
    ROUND(revenue - purchase_cost, 2) AS margin
  FROM {{ ref('int_sales_margin') }}
)

SELECT 
  orders_id,
  date_date,
  SUM(revenue) AS revenue,
  SUM(quantity) AS quantity,
  SUM(purchase_cost) AS purchase_cost,
  SUM(margin) AS margin
FROM subquery
GROUP BY orders_id, date_date
