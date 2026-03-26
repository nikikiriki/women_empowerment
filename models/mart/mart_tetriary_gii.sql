{{ config(
materialized='table'
) }}

select
*
from {{ ref('int_tetriary_gii') }}