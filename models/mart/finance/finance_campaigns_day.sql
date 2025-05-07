select
date_date,
ROUND(operational_margin - ads_cost, 2) as ads_margin,
average_basket,
operational_margin,
ads_cost,
ads_impression,
ads_clicks,
quantity,
revenue,
purchase_cost,
margin,
shipping_fee,
logcost,
ship_cost
    from {{ref('finance_days')}} as finance
        LEFT JOIN {{ref('int_campaigns_day')}} as campaign
            USING(date_date)