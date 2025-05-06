-- margin = revenue - purchase_cost
-- purchase_cost = quantity * purchase_price

WITH subquery AS (
  SELECT 
    products_id,
    products.purchase_price,
    sales.revenue,
    sales.quantity,
    sales.orders_id,
    ROUND(CAST(products.purchase_price AS FLOAT64) * sales.quantity, 2) AS purchase_cost
  FROM 
        {{ ref('stg_raw__sales') }} AS sales
        LEFT JOIN {{ ref('stg_raw__products') }} AS products 
            USING(products_id))), 

SELECT 
  orders_id, 
  date_date,
  SUM(revenue) as revenue,
  SUM(quantity) as quantity, 
  SUM(purchase_cost) as purchase_cost,
  SUM(ROUND(revenue - purchase_cost, 2)) AS margin
FROM subquery
group by orders_id, date_date