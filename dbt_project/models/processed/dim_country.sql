with dim_country as (
    SELECT country_key, country_name, capital, country_code,
        official_country_name, common_native_name
    FROM {{ ref("updated_travel_agency") }}
)
SELECT * FROM dim_country