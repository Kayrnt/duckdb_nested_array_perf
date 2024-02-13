{{
    config(
        materialized='external',
        location='./dimension_table.parquet'
    )
}}
SELECT * FROM {{ ref('dimension_table') }}
