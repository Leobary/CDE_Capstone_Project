WITH fact_country AS (
    SELECT country_key, independence_key, un_key, region_key, sub_region_key,
        continent_key, population, area
    FROM {{ ref("updated_travel_agency") }}
    ORDER BY country_key
)
SELECT * FROM fact_country