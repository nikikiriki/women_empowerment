with source as (

    select *
    from {{ source('women_empowerment', 'gii_years') }}

),

renamed as (

    select
        nullif(trim(countryIsoCode), '') as country_iso_code,
        nullif(trim(country), '') as country,
        nullif(trim(indexCode), '') as index_code,
        nullif(trim(index), '') as index_name,
        nullif(trim(dimension), '') as dimension,
        nullif(trim(indicatorCode), '') as indicator_code,
        nullif(trim(indicator), '') as indicator_name,
        cast(year as int64) as year,
        cast(yearStr as int64) as year_str,
        cast(actualValue as float64) as actual_value,
        cast(value as float64) as value

    from source

),

filtered as (

    select *
    from renamed
    where country_iso_code is not null
      and country is not null
      and indicator_code is not null
      and indicator_name is not null
      and year is not null

),

deduplicated as (

    select *
    from filtered
    qualify row_number() over (
        partition by country_iso_code, indicator_code, dimension, year
        order by year desc
    ) = 1

)

select *
from deduplicated