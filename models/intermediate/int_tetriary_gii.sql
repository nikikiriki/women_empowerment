WITH education AS (
    SELECT
        LOWER(TRIM(country_name)) AS country_name,
        CAST(year AS INT64) AS year,
        time_code,
        country_code,
        bachelors_f, bachelors_m, bachelors_tot,
        lower_secondary_f, lower_secondary_m, lower_secondary_tot,
        post_secondary_f, post_secondary_m, post_secondary_tot,
        primary_f, primary_m, primary_tot,
        short_cycle_tertiary_f, short_cycle_tertiary_m, short_cycle_tertiary_tot,
        upper_secondary_f, upper_secondary_m, upper_secondary_tot,
        masters_f, master_m, master_tot,
        doctoral_f, doctoral_m, doctoral_tot
    FROM {{ source('gdilonardo_staging', 'stg_women_empowerment__indicators_education') }}
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

edu_mapped AS (
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
        time_code,
        country_code,
        bachelors_f, bachelors_m, bachelors_tot,
        lower_secondary_f, lower_secondary_m, lower_secondary_tot,
        post_secondary_f, post_secondary_m, post_secondary_tot,
        primary_f, primary_m, primary_tot,
        short_cycle_tertiary_f, short_cycle_tertiary_m, short_cycle_tertiary_tot,
        upper_secondary_f, upper_secondary_m, upper_secondary_tot,
        masters_f, master_m, master_tot,
        doctoral_f, doctoral_m, doctoral_tot
    FROM education
)

SELECT
    e.*,
    g.gii_score
FROM edu_mapped e
INNER JOIN gii g
    ON e.country_name = g.country_name
    AND e.year = g.year