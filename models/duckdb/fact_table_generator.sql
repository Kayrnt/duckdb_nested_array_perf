{{
    config(
        materialized='external',
        location='./fact_table_' ~ (10 ** (var('exponent_scale') - 3)) ~ 'k.parquet'
    )
}}

SELECT * FROM {{ ref('fact_table') }}