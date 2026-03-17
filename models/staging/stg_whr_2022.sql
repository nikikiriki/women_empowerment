with source as (
    select * from {{ source('women_empowerment', 'whr_2022') }}
),

renamed as (
    select
      CAST(Country AS STRING)                                           as country_name,
CAST(`Happiness score` AS FLOAT64) / 1000                              as happiness_score,
CAST(`Explained by: GDP per capita` AS FLOAT64) / 1000               as gdp_per_capita,
CAST(`Explained by: Social support` AS FLOAT64) / 1000               as family_score,
CAST(`Explained by: Healthy life expectancy` AS FLOAT64) / 1000        as health_life_expectancy,
CAST(`Explained by: Freedom to make life choices` AS FLOAT64) / 1000   as freedom_score,
CAST(`Explained by: Perceptions of corruption` AS FLOAT64) / 1000      as trust_govt_corruption,
CAST(`Explained by: Generosity` AS FLOAT64) / 1000                     as generosity_score,
2022                                                              as year
    from source
    where Country != 'xx'
)

select * from renamed