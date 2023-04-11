{{
    config(materialized='table')
}}

SELECT
    promo_id,
    discount AS discount_percentage,
    status
FROM {{ source('postgres', 'promos') }}
