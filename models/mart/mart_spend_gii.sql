{{ config(
materialized='table'
) }}

select
*,
gdp_per_capita * spend_on_education as Spend_pro_capita_on_education
from {{ ref('int_spend_gii') }}