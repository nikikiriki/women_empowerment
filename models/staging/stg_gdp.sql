with source as (
    select * from {{ source('women_empowerment', 'gdp') }}
),

unpivoted as (
    select country_code, country_name, indicator_name, 2015 as year, cast(yr_2015 as float64) as gdp_value from source
    union all
    select country_code, country_name, indicator_name, 2016 as year, cast(yr_2016 as float64) as gdp_value from source
    union all
    select country_code, country_name, indicator_name, 2017 as year, cast(yr_2017 as float64) as gdp_value from source
    union all
    select country_code, country_name, indicator_name, 2018 as year, cast(yr_2018 as float64) as gdp_value from source
    union all
    select country_code, country_name, indicator_name, 2019 as year, cast(yr_2019 as float64) as gdp_value from source
    union all
    select country_code, country_name, indicator_name, 2020 as year, cast(yr_2020 as float64) as gdp_value from source
    union all
    select country_code, country_name, indicator_name, 2021 as year, cast(yr_2021 as float64) as gdp_value from source
    union all
    select country_code, country_name, indicator_name, 2022 as year, cast(yr_2022 as float64) as gdp_value from source
),

filtered as (
    select * from unpivoted
    where country_code NOT IN (
        'AFE', 'AFW', 'ARB', 'CEB', 'EAP', 'EAR', 'EAS', 'ECA', 'ECS',
        'FCS', 'HPC', 'IBD', 'IBT', 'IDA', 'IDB', 'IDX', 'LAC', 'LCN',
        'LDC', 'LIC', 'LMC', 'LMY', 'LTE', 'MEA', 'MIC', 'OED', 'OSS',
        'PRE', 'SAS', 'SSA', 'SSF', 'SST', 'TEA', 'TEC', 'TLA', 'TSA',
        'TSS', 'UMC', 'HIC', 'NAC', 'WLD', 'EMU', 'EUU', 'CSS', 'PSS',
        'PST', 'TMN', 'MNA'
    )
    and country_code is not null
    and gdp_value is not null
)

select * from filtered