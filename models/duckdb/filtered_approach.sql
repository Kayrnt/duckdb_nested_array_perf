{{
    config(
        materialized='table',
    )
}}

{% call set_sql_header(config) %}
-- PRAGMA enable_profiling;
-- SET enable_profiling = 'json';
-- SET enable_profiling = 'query_tree_optimizer';
-- SET memory_limit = '15GB';
PRAGMA temp_directory='/tmp/tmp.tmp';
{% endcall %}

WITH unnested AS (
  SELECT UNNEST(col15) st
  FROM {{ ref('fact_table') }}
),
fact_table_col15_name_values AS (
SELECT distinct st.name
from unnested
),
dimension_table_filtered AS (
SELECT st.*
FROM {{ ref('dimension_table') }} st
JOIN fact_table_col15_name_values v ON st.name = v.name
)
SELECT
  * exclude(col15),
  ARRAY(
    SELECT 
      {'id': st.id, 'bar': st.bar}
    FROM UNNEST(col15) AS c
    JOIN dimension_table_filtered AS st
      ON c.col15.name = st.name
    GROUP BY
      st.id,
      st.bar
  ) AS joined
FROM {{ ref('fact_table') }} AS bt