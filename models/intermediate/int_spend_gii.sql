WITH spend AS (
    SELECT
        LOWER(TRIM(country_name)) AS country_name,
        year,
        country_code,
        gdp_per_capita,
        gdp,
        spend_on_education
    FROM {{ ref('stg_spend') }}
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

spend_mapped AS (
    SELECT
        CASE country_name
            WHEN 'bolivia' THEN 'bolivia (plurinational state of)'
            WHEN 'congo, dem. rep.' THEN 'congo (democratic republic of the)'
            WHEN 'congo, rep.' THEN 'congo'
            WHEN 'egypt, arab rep.' THEN 'egypt'
            WHEN 'eswatini' THEN 'eswatini (kingdom of)'
            WHEN 'gambia, the' THEN 'gambia'
            WHEN 'iran, islamic rep.' THEN 'iran (islamic republic of)'
            WHEN 'korea, rep.' THEN 'korea (republic of)'
            WHEN 'kyrgyz republic' THEN 'kyrgyzstan'
            WHEN 'moldova' THEN 'moldova (republic of)'
            WHEN 'slovak republic' THEN 'slovakia'
            WHEN 'somalia, fed. rep.' THEN 'somalia'
            WHEN 'tanzania' THEN 'tanzania (united republic of)'
            WHEN 'turkiye' THEN 'türkiye'
            WHEN 'venezuela, rb' THEN 'venezuela (bolivarian republic of)'
            WHEN 'yemen, rep.' THEN 'yemen'
            ELSE country_name
        END AS country_name,
        year,
        country_code,
        gdp_per_capita,
        gdp,
        spend_on_education
    FROM spend
)

SELECT
    s.country_name,
    s.year,
    s.country_code,
    s.gdp_per_capita,
    s.gdp,
    s.spend_on_education,
    g.gii_score
FROM spend_mapped s
INNER JOIN gii g
    ON s.country_name = g.country_name
    AND s.year = g.year