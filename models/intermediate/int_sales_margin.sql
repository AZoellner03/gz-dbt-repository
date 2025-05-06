-- margin = revenue - purchase_cost
-- purchase_cost = quantity * purchase_price

WITH subquery AS (
  SELECT 
    products_id,
    products.purchase_price,
    sales.revenue,
    sales.quantity,
    sales.orders_id,
    ROUND(products.purchase_price * sales.quantity, 2) AS purchase_cost
  FROM 
        {{ ref('stg_raw__sales') }} AS sales
        LEFT JOIN {{ ref('stg_raw__products') }} AS products 
            USING(products_id))

SELECT 
  products_id, 
  ROUND(revenue - purchase_cost, 2) AS margin
FROM subquery


                
