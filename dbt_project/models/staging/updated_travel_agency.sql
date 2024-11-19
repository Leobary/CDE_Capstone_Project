-- This is used to generate keys for the travel agency source table
SELECT *, ROW_NUMBER() OVER (ORDER BY country_name) AS country_key,
    DENSE_RANK() OVER (ORDER BY continents) AS continent_key,
    DENSE_RANK() OVER (ORDER BY region) AS region_key,
    DENSE_RANK() OVER (ORDER BY sub_region) AS sub_region_key,
    CASE WHEN independence = TRUE THEN 1 ELSE 2 END AS independence_key,
    CASE WHEN united_nation_members = TRUE THEN 1 ELSE 2 END AS un_key,
FROM {{ ref("travel_agency") }}