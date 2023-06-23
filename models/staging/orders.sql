with
    source as (
        select 
            id as order_id
            , safe_cast(customer_id as int64) as customer_id
            , employee_id
            , order_type_id
            , order_date
            , split(return_date, ' ')[OFFSET(0)] as return_date
        from {{ source('sales_car', 'orders') }}
        -- are found two null ids customers
    ),
    treated as (
        select 
                order_id
                , customer_id
                , employee_id
                , order_type_id
                , cast(order_date as DATE) as order_date
                , safe_cast(return_date as DATE) as return_date
                , cast(split(return_date,'-')[OFFSET(0)] as int64) as return_year
                , cast(split(return_date,'-')[OFFSET(1)] as int64) as return_month
        from source
        where customer_id is not null
    ),
    final as (
        select 
                order_id
                , customer_id
                , employee_id
                , order_type_id
                , order_date
                , return_date
                , date_diff( 
                    case
                        when return_date is null then last_day(DATE(return_year, return_month, 1), MONTH)
                        else return_date
                    end, 
                    order_date,
                    DAY
                ) as days_diff
        from treated
    )

select * from final
