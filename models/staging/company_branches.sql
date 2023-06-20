with
    source as (
        select  
                id
                , country_code
                , upper(country) as country
                , state
                , upper(city) as city
                , split(upper(name), '-') as name --  SUBSTRING_INDEX(upper(name), '-', -1) ) as name
                , latitude
                , longitude
                , phone
        from    {{ source('sales_car', 'company_branches') }}
    ),
    treated as (
        select  distinct
                id as company_branch_id
                , country_code
                , country
                , state
                , city
                , concat ('LOJA - ', name[OFFSET(1)]) as name
                , latitude
                , longitude
                , phone
        from source -- virtual table step previous
    )

select * from treated
