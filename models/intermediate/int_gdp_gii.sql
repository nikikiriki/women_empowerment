WITH gdp AS (
    SELECT
        LOWER(TRIM(country_name)) AS country_name,
        year,
        gdp_value
    FROM `women-empowerment-490409.dbt_mreynoso_staging.gdp`
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

gdp_mapped AS (
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
        gdp_value
    FROM gdp
)

SELECT
    g2.country_name,
    g2.year,
    g2.gdp_value        AS gdp_per_capita,
    g.gii_score
FROM gdp_mapped g2
INNER JOIN gii g
    ON g2.country_name = g.country_name
    AND g2.year = g.year