with source as (
    select * from {{ source('women_empowerment', 'women_empowerment_index') }}
),

renamed as (
    select
        Country as country,
        
        "Women's Empowerment Index (WEI) - 2022" as womens_empowerment_index,
        
        "Women's Empowerment Group - 2022" as womens_empowerment_group,
        
        "Global Gender Parity Index (GGPI) - 2022" as gender_parity_index,
        
        "Gender Parity Group - 2022" as gender_parity_group,
        
        "Human Development Group - 2021" as human_development_group,
        
        "Sustainable Development Goal regions" as sdg_regions

    from source
)

select * from renamed