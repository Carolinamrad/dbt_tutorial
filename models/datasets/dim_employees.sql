with
    source as (
        select  distinct 
                employee_id
--                 , departament_id
--                , departament
--                , company_branches_id
                , first_name
                , last_name
                , gender
                , email
        from  {{ref('stg_employees')}}
    )

select * from source