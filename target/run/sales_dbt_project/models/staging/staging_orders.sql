
  create view "dbt_database"."public_staging"."staging_orders__dbt_tmp"
    
    
  as (
    WITH raw_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        total_amount,
        status
    FROM "dbt_database"."raw_data"."orders"
    WHERE status IN ('completed', 'shipped')
)
SELECT
    order_id,
    customer_id,
    order_date,
    total_amount,
    status
FROM raw_orders
  );