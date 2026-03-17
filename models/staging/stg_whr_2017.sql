with source as (
    select * from {{ source('women_empowerment', 'whr_2017') }}
),

renamed as (
    select
        Country                        as country_name,
        Happiness_Score                as happiness_score,
        Economy__GDP_per_Capita_       as gdp_per_capita,
        Family                         as family_score,
        Health__Life_Expectancy_       as health_life_expectancy,
        Freedom                        as freedom_score,
        Trust__Government_Corruption_  as trust_govt_corruption,
        Generosity                     as generosity_score,
        2017                           as year
    from source
)

select * from renamed