with dim_sub_region as (
    SELECT DISTINCT sub_region_key, sub_region
    FROM {{ ref("updated_travel_agency") }}
    ORDER BY sub_region_key
)
SELECT * FROM dim_sub_region