with source as (

    select *
    from {{ source('women_empowerment', 'gii_years') }}

),

renamed as (

    select
        nullif(trim(countryIsoCode), '') as countryIsoCode,
        nullif(trim(country), '') as country,
        nullif(trim(indexCode), '') as indexCode,
        nullif(trim(index), '') as index,
        nullif(trim(indicatorCode), '') as indicatorCode,
        nullif(trim(indicator), '') as indicator,
        cast(year as int64) as year,
        cast(value as float64) as value
    from source

)

select
    countryIsoCode,
    country,
    indexCode,
    index,
    indicatorCode,
    indicator,
    year,
    value
from renamed