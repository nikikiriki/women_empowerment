with 

source as (

    select * from {{ source('women_empowerment', 'whr_2015') }}

),

renamed as (

    select
        country,
        region,
        "happiness rank",
        "happiness score",
        "standard error",
        "economy _gdp per capita_",
        family,
        "health _life expectancy_",
        freedom,
        "trust _government corruption_",
        generosity,
        "dystopia residual"

    from source

)

select * from renamed