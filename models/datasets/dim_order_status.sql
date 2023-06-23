with
    source as (
        select  
            order_status as name_status
        from  {{ref('order_status')}}
    )

select
        ROW_NUMBER() OVER() as sk_order_status
        ,JSON_EXTRACT_SCALAR(TO_JSON_STRING(name_status), '$.order_status') as name_status
from source