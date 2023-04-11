{{
    config(materialized='table')
}}

SELECT
    address_id,
    address AS street_address,
    zipcode,
    state,
    country
FROM {{ source('postgres', 'addresses') }}
