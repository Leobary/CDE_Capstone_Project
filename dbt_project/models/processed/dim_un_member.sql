with dim_un_member as (
    SELECT DISTINCT un_key,
        CASE WHEN un_key = 1 THEN 'member'
            ELSE 'non-member' END un_member_status
    FROM {{ ref("updated_travel_agency") }}
    ORDER BY un_key
)
SELECT * FROM dim_un_member