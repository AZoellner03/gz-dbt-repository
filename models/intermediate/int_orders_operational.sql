WITH subquery AS (
  SELECT 
    margin_table.orders_id,
    date_date,
    revenue,
    quantity,
    ship.shipping_fee,
    ship.ship_cost,
    ship.logcost,
    ROUND(CAST(products.purchase_price AS FLOAT64) * sales.quantity, 2) AS purchase_cost
  FROM 
    {{ ref('int_orders_margin') }} AS margin_table
  LEFT JOIN 
    {{ ref('stg_raw__ship') }} AS ship
    USING(orders_id)
)

SELECT 
  orders_id, 
  date_date,
  ROUND(SUM(revenue + shipping_fee), 2) AS total_revenue,
  SUM(quantity) AS quantity, 
  ROUND(SUM(purchase_cost + logcost + ship_cost), 2) AS total_cost,
  ROUND(SUM(revenue + shipping_fee) - SUM(purchase_cost + logcost + ship_cost), 2) AS operational_margin
FROM subquery
GROUP BY orders_id, date_date
