-- margin = revenue - purchase_cost
-- purchase_cost = quantity * purchase_price

with subquery as(
  select 
    products.purchase_price,
    sales.revenue,
    sales.quantity,
    ROUND(products.purchase_price*sales.quantity, 2) as purchase_cost
        from 
        {{ref('stg_raw__products')}} as products
            RIGHT JOIN {{ref('stg_raw__sales')}} as sales
                USING(products_id))