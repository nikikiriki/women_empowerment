with gii as (
    select
        country,
        countryIsoCode,
        year,
        year_date,
        gii,
        lfpr_gap,
        pr_gap,
        se_gap
    from `women-empowerment-490409.dbt_mreynoso_staging.gii_indicators`
    where year between 2015 and 2022
),

gdp as (
    select distinct
        country_name,
        year,
        gdp_per_capita
    from {{ ref('int_gdp_gii') }}
),

happiness as (
    select distinct
        country_name,
        year,
        happiness_score
    from {{ ref('int_happiness_gii') }}
),

literacy as (
    select distinct
        country_name,
        latest_literacy_rate
    from {{ ref('int_literacy_gii') }}
),

tertiary as (
    select distinct
        country_name,
        year,
        short_cycle_tertiary_f,
        short_cycle_tertiary_m,
        short_cycle_tertiary_tot,
        lower_secondary_f,
        lower_secondary_m,
        lower_secondary_tot,
        bachelors_f,
        bachelors_m,
        bachelors_tot,
        masters_f,
        master_m,
        master_tot
    from {{ ref('int_tetriary_gii') }}
),

spend as (
    select distinct
        country_name,
        year,
        spend_on_education
    from {{ ref('int_spend_gii') }}
)

select
    gii.country                         as country_name,
    gii.countryIsoCode                  as country_iso_code,
    gii.year,
    gii.year_date,

    
    gii.gii                             as gii_score,
    gii.lfpr_gap,
    gii.pr_gap,
    gii.se_gap,

    
    gdp.gdp_per_capita,

    
    happiness.happiness_score,

    
    literacy.latest_literacy_rate,

    
    tertiary.short_cycle_tertiary_f,
    tertiary.short_cycle_tertiary_m,
    tertiary.short_cycle_tertiary_tot,

    
    tertiary.lower_secondary_f,
    tertiary.lower_secondary_m,
    tertiary.lower_secondary_tot,

    
    tertiary.bachelors_f,
    tertiary.bachelors_m,
    tertiary.bachelors_tot,
    tertiary.masters_f,
    tertiary.master_m,
    tertiary.master_tot,

    
    gdp.gdp_per_capita * spend.spend_on_education   as spend_pro_capita

from gii
left join gdp
    on LOWER(TRIM(gii.country)) = LOWER(TRIM(gdp.country_name))
    and gii.year = gdp.year
left join happiness
    on LOWER(TRIM(gii.country)) = LOWER(TRIM(happiness.country_name))
    and gii.year = happiness.year
left join literacy
    on LOWER(TRIM(gii.country)) = LOWER(TRIM(literacy.country_name))
left join tertiary
    on LOWER(TRIM(gii.country)) = LOWER(TRIM(tertiary.country_name))
    and gii.year = tertiary.year
left join spend
    on LOWER(TRIM(gii.country)) = LOWER(TRIM(spend.country_name))
    and gii.year = spend.year