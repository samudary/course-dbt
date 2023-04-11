{{
    config(materialized='table')
}}

SELECT
    product_id,
    inventory AS inventory_count,
    name AS product_name,
    price
FROM {{ source('postgres', 'products') }}
