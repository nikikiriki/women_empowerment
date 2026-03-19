WITH whr AS (
    SELECT
        LOWER(TRIM(country_name)) AS country_name,
        year,
        happiness_score
    FROM {{ ref('int_whr_all_years') }}
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

whr_mapped AS (
    SELECT
        CASE country_name
            WHEN 'russia' THEN 'russian federation'
            WHEN 'south korea' THEN 'korea (republic of)'
            WHEN 'turkey' THEN 'türkiye'
            WHEN 'congo (brazzaville)' THEN 'congo'
            WHEN 'congo (kinshasa)' THEN 'congo (democratic republic of the)'
            WHEN 'ivory coast' THEN 'côte d\'ivoire'
            WHEN 'laos' THEN 'lao people\'s democratic republic'
            WHEN 'iran' THEN 'iran (islamic republic of)'
            WHEN 'czech republic' THEN 'czechia'
            WHEN 'macedonia' THEN 'north macedonia'
            WHEN 'moldova' THEN 'moldova (republic of)'
            WHEN 'syria' THEN 'syrian arab republic'
            WHEN 'tanzania' THEN 'tanzania (united republic of)'
            WHEN 'swaziland' THEN 'eswatini (kingdom of)'
            WHEN 'taiwan' THEN 'taiwan (province of china)'
            WHEN 'taiwan province of china' THEN 'taiwan (province of china)'
            WHEN 'palestinian territories' THEN 'palestine, state of'
            WHEN 'trinidad & tobago' THEN 'trinidad and tobago'
            ELSE country_name
        END AS country_name,
        year,
        happiness_score
    FROM whr
)

SELECT
    w.country_name,
    w.year,
    w.happiness_score,
    g.gii_score
FROM whr_mapped w
INNER JOIN gii g
    ON w.country_name = g.country_name
    AND w.year = g.year