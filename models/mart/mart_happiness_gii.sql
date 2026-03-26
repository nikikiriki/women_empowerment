{{ config(
materialized='table'
) }}

select
*
from {{ ref('int_happiness_gii') }}