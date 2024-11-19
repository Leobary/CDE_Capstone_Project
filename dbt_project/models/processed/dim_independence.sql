with dim_independence as (
    SELECT DISTINCT independence_key,
        CASE WHEN independence_key = 1 THEN 'YES'
            ELSE 'NO' END independence_status
    FROM {{ ref("updated_travel_agency") }}
    ORDER BY independence_key
)
SELECT * FROM dim_independence