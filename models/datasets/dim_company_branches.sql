with
    source as (
        select  distinct 
                company_branch_id
                , country_code
                , country
                , state
                , city
                , name
                , latitude
                , longitude
                , phone

        from  {{ref('company_branches')}}

    )

select * from source