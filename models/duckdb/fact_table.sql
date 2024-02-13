{{
    config(
        materialized='table'
    )
}}
{# {% set name = './fact_table_' ~ 10 ** (var('exponent_scale') - 3)  ~ 'k.parquet' %} #}
{# {% set name = './fact_table_1M/*.parquet' %}
select * FROM read_parquet('{{ name }}') #}

{% call set_sql_header(config) %}
SET memory_limit = '15GB';
PRAGMA temp_directory='/tmp/tmp.tmp';
{% endcall %}

WITH 
array_id_int AS (
  SELECT 
      id,
      CAST(CAST(id AS INTEGER) % CAST({{ var('array_size_max') }} AS INTEGER) AS INTEGER) array_size,
      GENERATE_SERIES(0, array_size, 1) array_sample
  FROM {{ ref('all_rows')}}
)
SELECT
    CURRENT_TIMESTAMP AS hour,
    id,
    CONCAT('name ', id) AS name,
    id * 123 AS col1,
    id * 456 AS col2,
    CAST(id % 2 AS BOOLEAN) AS col3,
    id AS col4,
    CONCAT('col5 ', id) AS col5,
    id AS col6,
    CONCAT('col7 ', id) AS col7,
    CONCAT('col8 ', id) AS col8,
    CONCAT('col9 ', id) AS col9,
    CONCAT('col10 ', id) AS col10,
    CONCAT('col11 ', id) AS col11,
    CONCAT('col12 ', id) AS col12,
    array_sample AS col13,
      ARRAY(
      SELECT
        CONCAT('col14 ', x.array_sample)
      FROM UNNEST(a.array_sample) x
    ) AS col14,
    ARRAY(
      SELECT
        {'name': CONCAT('col15 ', x.array_sample), 'score': x.array_sample}
      FROM UNNEST(a.array_sample) x
    ) AS col15 
FROM array_id_int a