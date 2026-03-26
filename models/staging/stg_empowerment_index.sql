with source as (
    select * from {{ source('women_empowerment', 'women_empowerment_index') }}
),

renamed as (
  select
    Country as country,
    -- Usa il nome esatto suggerito dall'errore, senza le parentesi tonde se non ci sono
    `Women's Empowerment Index _WEI_ - 2022` as womens_empowerment_index,
    `Women's Empowerment Group - 2022` as womens_empowerment_group,
    `Global Gender Parity Index _GGPI_ - 2022` as gender_parity_index,
    `Gender Parity Group - 2022` as gender_parity_group,
    `Human Development Group - 2021` as human_development_group,
    `Sustainable Development Goal regions` as sdg_regions
  from source
=======
    select
        Country as country_name,
        
        `Women's Empowerment Index _WEI_ - 2022` as womens_empowerment_index,
        
        `Women's Empowerment Group - 2022` as womens_empowerment_group,
        
        `Global Gender Parity Index _GGPI_ - 2022` as gender_parity_index,
        
        `Gender Parity Group - 2022` as gender_parity_group,
        
        `Human Development Group - 2021` as human_development_group,
        
        `Sustainable Development Goal regions` as sdg_regions

    from source
>>>>>>> 26bbec5b854f52aa561d4af139e561fad9c390fe
)

select * from renamed