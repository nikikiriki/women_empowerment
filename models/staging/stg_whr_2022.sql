with source as (
    select * from {{ source('women_empowerment', 'whr_2022') }}
),

renamed as (
    select
        Country                                      as country_name,
        `Happiness score`                            as happiness_score,
        `Explained by: GDP per capita`               as gdp_per_capita,
        `Explained by: Social support`               as family_score,
        `Explained by: Healthy life expectancy`      as health_life_expectancy,
        `Explained by: Freedom to make life choices` as freedom_score,
        `Explained by: Perceptions of corruption`    as trust_govt_corruption,
        `Explained by: Generosity`                   as generosity_score,
        2022                                         as year
    from source
)

select * from renamed