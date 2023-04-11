{{
    config(materialized='table')
}}

SELECT
    order_id,
    address_id,
    user_id,
    promo_id,
    tracking_id,
    created_at,
    delivered_at,
    estimated_delivery_at,
    order_cost,
    order_total,
    shipping_cost,
    shipping_service,
    status
FROM {{ source('postgres', 'orders') }}
