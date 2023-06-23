with
    order_status as (
        select
                dos.sk_order_status
                , os.order_id
                , dos.name_status
        from    {{ ref('dim_order_status')}} dos
        left join {{ ref('order_status')}} os on os.order_status = dos.name_status
       
    ),
    source as (
        select
            ord.order_id
            , emp.company_branches_id
            , os.sk_order_status as fk_order_status
            , ord.customer_id
            , ord.employee_id
            , ord.order_type_id
            , emp.departament_id
            , ord.order_date
            , ord.days_diff
        from  {{ ref ('orders')}} ord
            INNER JOIN {{ ref ('stg_employees') }} emp ON emp.employee_id = ord.employee_id
            LEFT JOIN order_status os ON os.order_id = ord.order_id
    )

select * from source
