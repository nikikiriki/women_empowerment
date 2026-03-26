{{ config(
materialized='table'
) }}

select
*
from {{ ref('int_gdp_gii') }}