with 

source as (

    select * from {{ source('women_empowerment', 'indicators_education') }}

),

renamed as (

    select
        year,
        time_code,
        country_name,
        country_code,
        bachelors_f,
        bachelors_m,
        bachelors_tot,
        lower_secondary_f,
        lower_secondary_m,
        lower_secondary_tot,
        post_secondary_f,
        post_secondary_m,
        post_secondary_tot,
        primary_f,
        primary_m,
        primary_tot,
        short_cycle_tertiary_f,
        short_cycle_tertiary_m,
        short_cycle_tertiary_tot,
        upper_secondary_f,
        upper_secondary_m,
        upper_secondary_tot,
        masters_f,
        master_m,
        master_tot,
        doctoral_f,
        doctoral_m,
        doctoral_tot

    from source

)

select * from renamed