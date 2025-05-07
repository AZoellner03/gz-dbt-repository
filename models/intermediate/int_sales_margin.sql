-- margin = revenue - purchase_cost
-- purchase_cost = quantity * purchase_price

WITH subquery AS (
  SELECT 
    products_id,
    products.purchase_price,
    sales.revenue,
    sales.quantity,
    sales.orders_id,
    sales.date_date,
    ROUND(CAST(products.purchase_price AS FLOAT64) * sales.quantity, 2) AS purchase_cost
  FROM 
    {{ ref('stg_raw__sales') }} AS sales
  LEFT JOIN 
    {{ ref('stg_raw__products') }} AS products 
    USING(products_id)
)

SELECT 
  products_id,
  orders_id,
  date_date,
  revenue,
  quantity,
  purchase_cost,
  ROUND(revenue - purchase_cost, 2) AS margin
FROM subquery



                
