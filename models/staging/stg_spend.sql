WITH source AS (
    SELECT * FROM {{ source('women_empowerment', 'Spend') }}
),

renamed AS (
    SELECT
        CAST(Time AS INT64)     AS year,
        Country_Name            AS country_name,
        `Country Code`          AS country_code,
        GDP_per_capita_PPP      AS gdp_per_capita_ppp,
        GDP                     AS gdp,
        Spend_on_education      AS spend_on_education
    FROM source
    WHERE Country_Name IS NOT NULL
)

SELECT * FROM renamed