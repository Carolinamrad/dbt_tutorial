with
    source as (
        select  distinct  
                case
                    when order_status = 'delayed' then 'ATRASADO'
                    when order_status = 'on hold' then 'EM ESPERA'
                    when order_status = 'pending' then 'PENDENTE'
                    when order_status = 'shipped' then 'ENVIADO'
                    else 'OUTRO'
                end as order_status
        from {{ source('sales_car', 'orders') }}
    )

select cast(order_status as string) from source
    