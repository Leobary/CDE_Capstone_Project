with dim_region as (
    SELECT DISTINCT region_key, region
    FROM {{ ref("updated_travel_agency") }}
    ORDER BY region_key
)
SELECT * FROM dim_region