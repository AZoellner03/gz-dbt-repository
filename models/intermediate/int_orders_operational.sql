WITH subquery AS (
  SELECT 
    sales.orders_id,
    date_date,
    sales.revenue,
    sales.quantity,
    ship.shipping_fee,
    ship.ship_cost,
    ship.logcost,
    SUM(ROUND(revenue - purchase_cost, 2)) AS margin
    ROUND(CAST(products.purchase_price AS FLOAT64) * sales.quantity, 2) AS purchase_cost
  FROM 
        {{ ref('stg_raw__sales') }} AS sales
        LEFT JOIN {{ ref('stg_raw__ship') }} AS ship
            USING(orders_id))), 

SELECT 
  orders_id, 
  date_date,
  ROUND(revenue+shipping_fee,2) as total_revenue,
  SUM(quantity) as quantity, 
  ROUND(purchase_cost+logcost+ship_cost,2) as total_cost,
  ROUND((revenue+shipping_fee)-(purchase_cost+logcost+ship_cost),2) as operational_margin
FROM subquery
group by orders_id, date_date