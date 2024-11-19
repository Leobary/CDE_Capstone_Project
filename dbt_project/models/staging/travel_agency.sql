-- Select all the columns from the stage and cast to the necessary data types
SELECT
    data:country_name::STRING AS country_name,
	data:independence::BOOLEAN AS independence,
    data:united_nation_members::BOOLEAN AS united_nation_members,
	data:startOfWeek::STRING AS startOfWeek,
    data:official_country_name::STRING AS official_country_name,
	data:common_native_name::STRING AS common_native_name,
    data:currency_code::STRING AS currency_code,
	data:currency_name::STRING AS currency_name,
    data:currency_symbol::STRING AS currency_symbol,
	data:country_code::STRING AS country_code,
    data:capital::STRING AS capital,
	data:region::STRING AS region,
    data:sub_region::STRING AS sub_region,
	data:languages::STRING AS languages,
    data:area::FLOAT AS area,
	data:population::INTEGER AS population,
    data:continents::STRING AS continents
FROM STAGING_TABLE