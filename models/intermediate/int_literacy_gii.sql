WITH literacy AS (
    SELECT
        LOWER(TRIM(country_name)) AS country_name,
        latest_literacy_rate,
        literacy_2022
    FROM {{ ref('stg_literacy') }}
),

gii AS (
    SELECT
        LOWER(TRIM(country)) AS country_name,
        year,
        value AS gii_score
    FROM {{ source('mreynoso_staging', 'stg_gii_years') }}
    WHERE indicatorCode = 'gii'
    AND year BETWEEN 2015 AND 2022
),

literacy_mapped AS (
    SELECT
        CASE country_name
            WHEN 'bolivia' THEN 'bolivia (plurinational state of)'
            WHEN 'congo, dem. rep.' THEN 'congo (democratic republic of the)'
            WHEN 'egypt, arab rep.' THEN 'egypt'
            WHEN 'eswatini' THEN 'eswatini (kingdom of)'
            WHEN 'gambia, the' THEN 'gambia'
            WHEN 'iran, islamic rep.' THEN 'iran (islamic republic of)'
            WHEN 'somalia, fed. rep.' THEN 'somalia'
            WHEN 'tanzania' THEN 'tanzania (united republic of)'
            WHEN 'turkiye' THEN 'turkiye'
            WHEN 'venezuela, rb' THEN 'venezuela (bolivarian republic of)'
            ELSE country_name
        END AS country_name,
        latest_literacy_rate,
        literacy_2022
    FROM literacy
)

SELECT
    l.country_name,
    l.latest_literacy_rate,
    l.literacy_2022,
    g.year,
    g.gii_score
FROM literacy_mapped l
INNER JOIN gii g
    ON l.country_name = g.country_name