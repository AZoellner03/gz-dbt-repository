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
    from {{ref('int_campaigns_day')}} as campaign
        LEFT JOIN {{ref('finance_days')}} as finance
            USING(date_date)