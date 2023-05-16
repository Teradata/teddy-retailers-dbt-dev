with product_order_details as (
    
    select * from {{ ref('product_order_details')}} 

),
orders as (

    select * from {{ ref('all_orders')}} 

),
final as (

    select 
        orders.order_id,
        orders.customer_id as customer_id,
        orders.order_date as order_date,
        sum(quantity) as item_quantity,
        sum(amount) as total_value
    From product_order_details
    LEFT JOIN orders on product_order_details.order_id = orders.order_id
    GROUP BY 1, 2, 3
)
select * from final