{{
    config(
        materialized='table',
    )
}}
{% set rows_count = 10 ** var('exponent_scale') %}
WITH array_id AS (
SELECT GENERATE_ARRAY(1, {{ rows_count }}, 1) AS ids
),
array_with_id AS (
  SELECT 
      id,
      MOD(id, {{ var('array_size_max') }}) array_size
  FROM array_id, UNNEST(ids) id
),
array_with_size AS (
SELECT 
    id, array_size,
    GENERATE_ARRAY(0, array_size, 1) array_sample
FROM array_with_id
)
SELECT
TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL CAST(id * 60 AS INT64) MINUTE) hour,
id,
CONCAT("name ", id) name,
id * 123 col1,
id * 456 col2,
CAST(MOD(id, 2) AS BOOLEAN) AS col3,
id col4,
CONCAT("col5 ", id) col5,
id col6,
CONCAT("col7 ", id) col7,
CONCAT("col8 ", id) col8,
CONCAT("col9 ", id) col9,
CONCAT("col10 ", id) col10,
CONCAT("col11 ", id) col11,
CONCAT("col12 ", id) col12,
array_sample AS col13,
ARRAY(
SELECT CONCAT("col14 ", CAST(id * 10000 AS INT64))
FROM UNNEST(array_sample) x) AS col14,
ARRAY(
SELECT AS STRUCT CONCAT("col15 ", MOD(x, {{ var('array_size_max') }})) name, x as score
FROM UNNEST(array_sample) x) AS col15
FROM array_with_size
