with all_years as (
    select country_name, happiness_score, '2015' as year from {{ ref('stg_whr_2015') }}
    union all
    select country_name, happiness_score, '2016' as year from {{ ref('stg_whr_2016') }}
    union all
    select country_name, happiness_score, '2017' as year from {{ ref('stg_whr_2017') }}
    union all
    select country_name, happiness_score, '2018' as year from {{ ref('stg_whr_2018') }}
    union all
    select country_name, happiness_score, '2019' as year from {{ ref('stg_whr_2019') }}
    union all
    select country_name, happiness_score, '2020' as year from {{ ref('stg_whr_2020') }}
    union all
    select country_name, happiness_score, '2021' as year from {{ ref('stg_whr_2021') }}
    union all
    select country_name, happiness_score, '2022' as year from {{ ref('stg_whr_2022') }}
)

select * from all_years