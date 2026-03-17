with source as (
    select * from {{ source('women_empowerment', 'gii_years') }}
),

renamed as (
    select
        countryIsoCode                   as country_code,
        country                          as country_name,
        indexCode                        as index_code,
        index                            as index_name,
        indicatorCode                    as indicator_code,
        indicator                        as indicator_name,
        year                             as year,
        value                            as gii_value,
    from source
)

select * from renamed

