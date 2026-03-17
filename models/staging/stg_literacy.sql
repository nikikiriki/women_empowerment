with source as (
    select * from {{ source('women_empowerment', 'literacy_rate') }}
),

renamed as (
    select
        Country_Name    as country_name,
        Country_Code    as country_code,
        Indicator_Name  as indicator_name,
        yr_2015         as literacy_2015,
        yr_2016         as literacy_2016,
        yr_2017         as literacy_2017,
        yr_2018         as literacy_2018,
        yr_2019         as literacy_2019,
        yr_2020         as literacy_2020,
        yr_2021         as literacy_2021,
        yr_2022         as literacy_2022,
        COALESCE(yr_2022, yr_2021, yr_2020, yr_2019, 
                 yr_2018, yr_2017, yr_2016, yr_2015) as latest_literacy_rate
    from source
    where Country_Name is not null
      and COALESCE(yr_2022, yr_2021, yr_2020, yr_2019,
                   yr_2018, yr_2017, yr_2016, yr_2015) IS NOT NULL
)

select * from renamed