{{ config(alias='customers')}}

with
    source as (
        select 
            id as customer_id
            , upper(first_name) as first_name
            , upper(last_name) as last_name
            , gender
            , upper(job_title) as job_title
            , phone 
            , upper(email) as email
            , country_code
            , upper(country) as country
            , upper(city) as city
            , latitude
            , longitude
            , recurring_customer is_recurring
            , upper(customer_level) as level
            , registration_date
        from {{ source('seeds', 'customers') }}
        -- are found two null ids customers
    )

select * from source
