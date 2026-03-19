SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2015') }}
UNION ALL
SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2016') }}
UNION ALL
SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2017') }}
UNION ALL
SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2018') }}
UNION ALL
SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2019') }}
UNION ALL
SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2020') }}
UNION ALL
SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2021') }}
UNION ALL
SELECT country_name, year, happiness_score FROM {{ ref('stg_whr_2022') }}