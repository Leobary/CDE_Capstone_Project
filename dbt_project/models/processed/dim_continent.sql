with dim_continent as (
    SELECT DISTINCT continent_key, continents
    FROM {{ ref("updated_travel_agency") }}
    ORDER BY continent_key
)
SELECT * FROM dim_continent