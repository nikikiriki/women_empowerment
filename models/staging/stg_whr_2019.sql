with source as (
    select * from {{ source('women_empowerment', 'whr_2019') }}
),

renamed as (
    select
        `Country or region`            as country_name,
        Score                          as happiness_score,
        `GDP per capita`               as gdp_per_capita,
        `Social support`               as family_score,
        `Healthy life expectancy`      as health_life_expectancy,
        `Freedom to make life choices` as freedom_score,
        CAST(`Perceptions of corruption` AS FLOAT64) as trust_govt_corruption,
        Generosity                     as generosity_score,
        2019                           as year
    from source
)

select * from renamed