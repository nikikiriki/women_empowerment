with source as (

    select *
from {{ source('women_empowerment', 'gdp') }}

),

unpivoted as (

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2015 as year,
        cast(yr_2015 as float64) as gdp_value
    from source

    union all

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2016 as year,
        cast(yr_2016 as float64) as gdp_value
    from source

    union all

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2017 as year,
        cast(yr_2017 as float64) as gdp_value
    from source

    union all

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2018 as year,
        cast(yr_2018 as float64) as gdp_value
    from source

    union all

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2019 as year,
        cast(yr_2019 as float64) as gdp_value
    from source

    union all

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2020 as year,
        cast(yr_2020 as float64) as gdp_value
    from source

    union all

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2021 as year,
        cast(yr_2021 as float64) as gdp_value
    from source

    union all

    select
        nullif(trim(Country_Code), '') as country_code,
        nullif(trim(Country_Name), '') as country_name,
        nullif(trim(Indicator_Name), '') as indicator_name,
        2022 as year,
        cast(yr_2022 as float64) as gdp_value
    from source

),

filtered as (

    select *
    from unpivoted
    where country_code is not null
      and country_name is not null
      and indicator_name is not null
      and gdp_value is not null

),

deduplicated as (

    select *
    from filtered
    qualify row_number() over (
        partition by country_code, indicator_name, year
        order by year desc
    ) = 1

)

select *
from deduplicated