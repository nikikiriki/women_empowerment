{{ config(
materialized='table'
) }}

select
*
from {{ ref('int_literacy_gii') }}