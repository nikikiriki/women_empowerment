with source as (
    select * from {{ source('women_empowerment', 'whr_2015') }}
),

renamed as (
    select
        Country                          as country_name,
        Region                           as region,
        `Happiness Rank`                 as happiness_rank,
        `Happiness Score`                as happiness_score,
        `Economy _GDP per Capita_`       as gdp_per_capita,
        Family                           as family_score,
        `Health _Life Expectancy_`       as health_life_expectancy,
        Freedom                          as freedom_score,
        `Trust _Government Corruption_`  as trust_govt_corruption,
        Generosity                       as generosity_score,
        `Dystopia Residual`              as dystopia_residual,
        2015                             as year
    from source
)

select * from renamed