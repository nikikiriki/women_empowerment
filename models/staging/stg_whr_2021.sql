with source as (
    select * from {{ source('women_empowerment', 'whr_2021') }}
),

renamed as (
    select
        `Country name`                 as country_name,
        `Ladder score`                 as happiness_score,
        `Logged GDP per capita`        as gdp_per_capita,
        `Social support`               as family_score,
        `Healthy life expectancy`      as health_life_expectancy,
        `Freedom to make life choices` as freedom_score,
        `Perceptions of corruption`    as trust_govt_corruption,
        Generosity                     as generosity_score,
        2021                           as year
    from source
)

select * from renamed