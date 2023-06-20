with
    source as (
        select  
                id
                , order_id
                , order_type_id
                , split(upper(item),'@~|~@') as item
                -- , ARRAY_LENGTH (REGEXP_EXTRACT_ALL(item, '@~\\|~@')) as occurences **** essa linha seria necessária caso nem todas os registros do campo item tivessem o mesmo número de ocorrenias Ex. não tivesse o valor
        from    {{ source('sales_car', 'order_items') }}
    ),
    treated as (
        select  
                id as order_item_id
                , order_id
                , order_type_id as id_type
                , item[OFFSET(0)] as model
                , item[OFFSET(1)] as number_review
                , item[OFFSET(2)] as review
                , item[OFFSET(3)] as price
        from source
    )

select * from treated
